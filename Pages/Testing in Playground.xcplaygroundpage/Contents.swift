//: [Previous](@previous)
/*:

# Unit Testing in Playground

Check Stuart Sharpe's article [TTD in Swift Playground](http://initwithstyle.net/2015/11/tdd-in-swift-playgrounds/) for more info about Unit Testing in Playground

The main idea is to use `XCTestObservation` protocol and `XCTestObservationCenter`.

Basically, when ever a test is run in xcode, `XCTestObservationCenter` can dispatch event to any registered class conform to `XCTestObservation`.

We're piggy backing on XCode Unit Test to run our Unit Test in XCode.

`XCTestObservationCenter` dispatch multiples event but the one we're really interested in is `testCase:didFailWithDescription:inFile:atLine:`

*/

/*:

## Observe & Report

In order to report filing tests, we also need to add a test observer, conforming to XCTestObservation, which will be notified whenever a test fails and print the failure to the console. The observer is then added to the XCTestObservationCenter to allow the system to notify the observer of test failures

*/

import XCTest

class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(testCase.name), \(description)")
    }
}

let observer = PlaygroundTestObserver()
let center = XCTestObservationCenter.sharedTestObservationCenter()
center.addTestObserver(observer)

//: ## The Running Man
//:
//: After this is the TestRunner, which runs the tests from an XCTestCase and reports on the results. This is done using the same XCTestSuite mechanism which Xcode uses to run unit tests. At the end of the run, a message is printed to the console, telling you how many tests were run, how long it took, and how many of the tests failed.

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

//: Don't forget to run your testCases

// TestRunner().runTests(testCases)

//: [Next](@next)
