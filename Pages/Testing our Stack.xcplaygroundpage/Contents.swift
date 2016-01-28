//: [Previous](@previous)
/*:

## Let's test our generic stack with somes Ints

*/

import XCTest

class IntStackTests : XCTestCase {
    
    func testEmpty() {
        let s = Stack<Int>()
        XCTAssertEqual(s.items.count, 0)
    }
    
    func testPush() {
        let s = Stack<Int>()
        s.push(3)
        XCTAssertTrue(s.items.contains(3))
        XCTAssertEqual(s.items.count, 1)
    }
    
    func testPushSomes() {
        let s = Stack<Int>()
        s.push(1)
        s.push(2)
        s.push(3)
        XCTAssertEqual(s.items.count, 3)
        XCTAssertEqual(s.items.first, 1)
        XCTAssertTrue(s.items.contains(2))
        XCTAssertEqual(s.items.last, 3)
        XCTAssertEqual(s.items.count, 3)
    }
    
    func testPop() {
        let s = Stack<Int>()
        s.push(3)
        XCTAssertEqual(s.items.count, 1)
        XCTAssertEqual(s.pop(), 3)
        XCTAssertEqual(s.items.count, 0)
    }
    
    func testPopNone() {
        let s = Stack<Int>()
        XCTAssertEqual(s.pop(), nil)
    }
    
    func testPopSomes() {
        let s = Stack<Int>()
        s.push(1)
        s.push(2)
        s.push(3)
        XCTAssertEqual(s.items.count, 3)
        XCTAssertEqual(s.pop(), 3)
        XCTAssertEqual(s.pop(), 2)
        s.push(4)
        XCTAssertEqual(s.pop(), 4)
        XCTAssertEqual(s.pop(), 1)
        XCTAssertEqual(s.items.count, 0)
    }
    
    func testPeek() {
        let s = Stack<Int>()
        s.push(1)
        XCTAssertEqual(s.items.count, 1)
        XCTAssertEqual(s.peek(), 1)
        XCTAssertEqual(s.items.count, 1)
    }
    
    func testPeekNone() {
        let s = Stack<Int>()
        XCTAssertEqual(s.peek(), nil)
    }
    
    func testPeekSomes() {
        let s = Stack<Int>()
        s.push(1)
        s.push(2)
        s.push(3)
        XCTAssertEqual(s.items.count, 3)
        XCTAssertEqual(s.peek(), 3)
        XCTAssertEqual(s.items.count, 3)
        s.pop()
        XCTAssertEqual(s.items.count, 2)
        XCTAssertEqual(s.peek(), 2)
        XCTAssertEqual(s.items.count, 2)
    }
}

//: [Next](@next)























//: Unit Test Boilerplate (tricky to move to source files)

class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(testCase.name), \(description)")
    }
}

let observer = PlaygroundTestObserver()
let center = XCTestObservationCenter.sharedTestObservationCenter()
center.addTestObserver(observer)

struct TestRunner {

    func runTests(testClass:AnyClass) {
        print("Running test suite \(testClass)")

        let tests = testClass as! XCTestCase.Type

        // grab the default test suit of the test case
        let testSuite = tests.defaultTestSuite()

        // run the test
        testSuite.runTest()

        // collect and display informations about the tests run
        let testRun = testSuite.testRun as! XCTestSuiteRun
        
        print("Ran \(testRun.executionCount) tests in \(testRun.testDuration)s with \(testRun.totalFailureCount) failures")
    }

}

TestRunner().runTests(IntStackTests)

//: [Next](@next)