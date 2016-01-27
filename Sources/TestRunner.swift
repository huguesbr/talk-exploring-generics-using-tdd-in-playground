//: ## The Running Man
//:
//: After this is the TestRunner, which runs the tests from an XCTestCase and reports on the results. This is done using the same XCTestSuite mechanism which Xcode uses to run unit tests. At the end of the run, a message is printed to the console, telling you how many tests were run, how long it took, and how many of the tests failed.

import XCTest


//: !!!: Any class (and method) in Playground source's files which will be use directly by playground, need to be mark as public

public struct TestRunner {
    
    public init() {
    }
    
    public func runTests(testClass:AnyClass) -> XCTestSuiteRun {
        print("Running test suite \(testClass)")
        
        let tests = testClass as! XCTestCase.Type
        
        // grab the default test suit of the test case
        let testSuite = tests.defaultTestSuite()
        
        // run the test
        testSuite.runTest()
        
        // collect and display informations about the tests run
        return testSuite.testRun as! XCTestSuiteRun
    }
    
}