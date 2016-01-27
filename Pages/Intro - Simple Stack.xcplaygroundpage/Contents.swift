/*:

# Swift Generics in TDD Playgrounds

Thanks to Stuart Sharpe on initWithStyle and Mattt Thompson on NSHipster

*/

//: ## First, let's build a simple generic stack

class Stack<T> {
    var items:[T]
    
    init(){
        self.items = []
    }
    
    func push(value:T) {
        items.append(value)
    }
    
    func pop() -> T? {
        return items.popLast()
    }
    
    func peek() -> T? {
        if items.count == 0 { return nil }
        return items[items.count - 1]
    }
}

//: ## Let's test it with somes 

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
        XCTAssertEqual(s.items.count, 4)
    }
}

/*:

# Unit Test Boilerplate

Check Stuart Sharpe's article [TTD in Swift Playground](http://initwithstyle.net/2015/11/tdd-in-swift-playgrounds/) for more info about Unit Testing in Playground

*/

/*:

## Observe & Report

In order to report filing tests, we also need to add a test observer, conforming to XCTestObservation, which will be notified whenever a test fails and print the failure to the console. The observer is then added to the XCTestObservationCenter to allow the system to notify the observer of test failures

*/

class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(testCase.name), \(description)")
    }
}

let observer = PlaygroundTestObserver()
let center = XCTestObservationCenter.sharedTestObservationCenter()
center.addTestObserver(observer)

//: ## Run the test suit

//let suiteResults = TestRunner().runTests(IntStackTests)
//print("Ran \(suiteResults.executionCount) tests in \(suiteResults.testDuration)s with \(suiteResults.totalFailureCount) failures")

//: [Next](@next)
