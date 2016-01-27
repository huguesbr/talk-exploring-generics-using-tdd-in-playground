//: [Previous](@previous)

//: # Thanks to Mattt Thompson article about Swift Comparison Protocols
//: (http://nshipster.com/swift-comparison-protocols/)[http://nshipster.com/swift-comparison-protocols/]

import Foundation

struct CSSSelector {
    let selector: String
    
    struct Specificity {
        let id: Int
        let `class`: Int
        let element: Int
        
        init(_ components: [String]) {
            var (id, `class`, element) = (0, 0, 0)
            for token in components {
                if token.hasPrefix("#") {
                    id++
                } else if token.hasPrefix(".") {
                    `class`++
                } else {
                    element++
                }
            }
            
            self.id = id
            self.`class` = `class`
            self.element = element
        }
    }
    
    let specificity: Specificity
    
    init(_ string: String) {
        self.selector = string
        
        // Naïve tokenization, ignoring operators, pseudo-selectors, and `style=`.
        let components: [String] = self.selector.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        self.specificity = Specificity(components)
    }
}

// MARK: ## Let's make it Equatable

func ==(lhs: CSSSelector, rhs: CSSSelector) -> Bool {
    // Naïve equality that uses string comparison rather than resolving equivalent selectors
    return lhs.selector == rhs.selector
}
extension CSSSelector: Equatable {}

// MARK: ## Let's make it Comparable

// MARK: ### We first need to make CSS specificity Equatable And comparable

func <(lhs: CSSSelector.Specificity, rhs: CSSSelector.Specificity) -> Bool {
    return lhs.id < rhs.id ||
        lhs.`class` < rhs.`class` ||
        lhs.element < rhs.element
}
extension CSSSelector.Specificity: Comparable {}

func ==(lhs: CSSSelector.Specificity, rhs: CSSSelector.Specificity) -> Bool {
    return lhs.id == rhs.id &&
        lhs.`class` == rhs.`class` &&
        lhs.element == rhs.element
}
extension CSSSelector.Specificity: Equatable {}

// MARK: ## Now we can make CSSSelector Comparable

func <(lhs: CSSSelector, rhs: CSSSelector) -> Bool {
    return lhs.specificity < rhs.specificity
}
extension CSSSelector: Comparable {}

//: Let's test it

import XCTest

class CSSSelectorTests : XCTestCase {
    
    func testIdOverClass() {
        let a = CSSSelector("#logo")
        let b = CSSSelector(".logo")
        XCTAssertTrue(a > b)
        XCTAssertTrue(a < b)
    }
    
    func testClassOverElement() {
        let a = CSSSelector(".logo")
        let b = CSSSelector("div")
        XCTAssertTrue(a > b)
    }
    
    func testMultipleSpecifities() {
        let a = CSSSelector("html #logo")
        let b = CSSSelector(".container #logo")
        //!?
        XCTAssertTrue(a > b)
        XCTAssertTrue(a < b)
    }
    
}


//: # Unit Test Boilerplate

//: ## Observe & Report
//:
//: In order to report filing tests, we also need to add a test observer, conforming to XCTestObservation, which will be notified whenever a test fails and print the failure to the console. The observer is then added to the XCTestObservationCenter to allow the system to notify the observer of test failures:

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
        let testSuite = tests.defaultTestSuite()
        testSuite.runTest()
        let run = testSuite.testRun as! XCTestSuiteRun
        
        print("Ran \(run.executionCount) tests in \(run.testDuration)s with \(run.totalFailureCount) failures")
    }
    
}

//: ## Run the test suit

TestRunner().runTests(ComposedTests)
TestRunner().runTests(SpecifitityComparableTests)
TestRunner().runTests(CSSSelectorTests)

//: [Next](@next)
