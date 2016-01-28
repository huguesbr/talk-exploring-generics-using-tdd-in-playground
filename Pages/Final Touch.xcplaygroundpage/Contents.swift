//: [Previous](@previous)
/*: 

# (Grand) finale

Let's spice up the sauce by mixing the everything together
Try out our generic MaxStack with CSSSelector, not extra code required...

*/

import XCTest

class CSSMaxSelectorTests : XCTestCase {
    
    func testMaxSelector() {
        let stack = MaxStack<CSSSelector>()
        let a = CSSSelector("#logo")
        let b = CSSSelector("div")
        let c = CSSSelector("div #logo")
        let d = CSSSelector(".container #logo")
        stack.push(a)
        stack.push(b)
        stack.push(c)
        stack.push(d)
        XCTAssertEqual(stack.getMax(), d)
    }
    
}


/*:

    ## Conclusion

    Generics allow to **focus on underlying behaviors required by a class** in order to accomplish a task.

    It improve **re-usability** (discoverability might be an issue) and **testability** (generics are easier to test because not dependent of a class but a procotocol, reduce usage of Mocks).

    Where to go from here?
    We could have implemented our stack as a protocol and have its default implementation using protocol extension, likewise for maxStack and then add this behavior to a CSSDocument class.

*/
























//: # Unit Test Boilerplate

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
        let testSuite = tests.defaultTestSuite()
        testSuite.runTest()
        let run = testSuite.testRun as! XCTestSuiteRun
        
        print("Ran \(run.executionCount) tests in \(run.testDuration)s with \(run.totalFailureCount) failures")
    }
    
}


TestRunner().runTests(CSSMaxSelectorTests)




