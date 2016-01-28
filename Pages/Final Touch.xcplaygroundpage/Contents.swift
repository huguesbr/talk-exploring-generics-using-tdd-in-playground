//: [Previous](@previous)
/*: 

# (Grand) finale

Let's spice up the sauce by mixing the everything together

Try out our generic MaxStack with CSSSelector, not extra code required...

Let's write our test first like good TDD.

*/

import XCTest

class CSSMaxSelectorTests : XCTestCase {
    
    // testMaxSelector?
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

//: Well, nothing else, our code just works!


/*:

## Conclusion

Generics allow to **focus on underlying behaviors required by a class** in order to accomplish a specific task.

It improve **re-usability**, sometimes for free (long term discoverability might be an issue) and **testability**.

Where to go from here?
* Could we have implemented our stack as a protocol?
* Declaring maxStack conform to this protocol?
* Write a unit-test for our protocol and then for having maxStack partially tested for free?
* **[Protocol Oriented Programming: WWDC 2015 (Dave Abrahams)](https://developer.apple.com/videos/play/wwdc2015-408/)**: https://developer.apple.com/videos/play/wwdc2015-408/

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




