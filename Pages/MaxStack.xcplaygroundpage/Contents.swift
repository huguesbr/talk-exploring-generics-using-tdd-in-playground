//: [Previous](@previous)
/*:

# Building a stack keeping track of max element using Protocol oriented programming

In order to keep track of a max item, we just need a way to compare them.
Luckily we can express this using generics.

Generics allow to express protocol requirement.
(You could do this in Objective-C using `id<SomeProtocol>`)

Swift have declare equivalency and comparaison using protocol, not possible in Obj-C (Also, thanks to operator overloading...)
So we can express the **comparable requirement** in our generics implementation.

Also, the homogeneous requirement of Generics allows us to avoid comparing Apple and Robot...

*/

//: Let's test it (a tiny bit)

import XCTest

class MaxStackTests : XCTestCase {
    
    func testEmpty() {
        let s = MaxStack<Int>()
        XCTAssertEqual(s.getMax(), nil)
    }
    
    func testMax() {
        let s = MaxStack<Int>()
        s.push(3)
        s.push(1)
        XCTAssertEqual(s.getMax(), 3)
    }
    
    func testLastMax() {
        let s = MaxStack<Int>()
        s.push(2)
        s.push(1)
        s.push(3)
        XCTAssertEqual(s.getMax(), 3)
        s.pop()
        XCTAssertEqual(s.getMax(), 2)
    }
    
    /*:
    TODO: Other tests related to stack behavior
    
    Question: How could we adapt our Stack and Unit Test to be able to re-use it here?
    */
}

class MaxStack<T:Comparable> {
    var items:Stack<T>
    var maxStack:Stack<T>
    
    init(){
        self.items = Stack<T>()
        self.maxStack = Stack<T>()
    }
    
    func push(value:T) {
        if let maxValue = maxStack.peek() {
            if(value >= maxValue) {
                maxStack.push(value)
            }
        } else {
            maxStack.push(value)
        }
        items.push(value)
    }
    
    func pop() -> T? {
        guard let value = items.pop() else { return nil }
        if let maxValue = maxStack.peek() {
            if(value == maxValue) { maxStack.pop() }
        }
        return value
    }
    
    func peek() -> T? {
        return items.peek()
    }
    
    func getMax() -> T? {
        return maxStack.peek()
    }
}

//: [Next](@next)







































class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(testCase.name), \(description)")
    }
    
    @objc func testCaseWillStart(testCase: XCTestCase) {
        print("Running: \(testCase.name)")
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

TestRunner().runTests(MaxStackTests)



