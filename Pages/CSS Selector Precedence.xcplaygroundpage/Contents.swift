//: [Previous](@previous)
/*:

# CSS selectors precedence

CSS selectors might be "conflicting", browse needs to decide which one of these statements to honor. (precedence)

Ex.:
* `div { color: blue; }`
* `.favorite { color: blue; }`
* `#header .favorite { color: red; }`

In order to determine precedence, CSS use the most precise selector.

The specificity of a selector could be (drastically reduce, for this exemple) by counting the number of specifity selector token (`#`, `.`, none).
We could then determine the most precise selector by comparing this counter.

Thanks to **Mattt Thompson**'s article about **Swift Comparison Protocols**, we have a draft implementation of this.
Check it out here: 
    http://nshipster.com/swift-comparison-protocols/
*/

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
        
        // **Naïve** tokenization, ignoring operators, pseudo-selectors, and `style=`.
        let components: [String] = self.selector.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        self.specificity = Specificity(components)
    }
}

//: ## Let's make it Equatable

extension CSSSelector: Equatable {}
func ==(lhs: CSSSelector, rhs: CSSSelector) -> Bool {
    // Naïve equality that uses string comparison rather than resolving equivalent selectors
    return lhs.selector == rhs.selector
}

//: ## Let's make it Comparable

//: ### We first need to make CSS specificity Equatable And comparable

extension CSSSelector.Specificity: Comparable {}
func <(lhs: CSSSelector.Specificity, rhs: CSSSelector.Specificity) -> Bool {
    let result = lhs.id < rhs.id ||
        (lhs.id == rhs.id && lhs.`class` < rhs.`class`) ||
        (lhs.id == rhs.id && lhs.`class` == rhs.`class` && lhs.element < rhs.element)
    
    return result
}

extension CSSSelector.Specificity: Equatable {}
func ==(lhs: CSSSelector.Specificity, rhs: CSSSelector.Specificity) -> Bool {
    return lhs.id == rhs.id &&
        lhs.`class` == rhs.`class` &&
        lhs.element == rhs.element
}

//: Now we can make CSSSelector Comparable

extension CSSSelector: Comparable {}
func <(lhs: CSSSelector, rhs: CSSSelector) -> Bool {
    return lhs.specificity < rhs.specificity
}

//: ## Let's, quickly, test it

import XCTest

class CSSSelectorTests : XCTestCase {
    
    func testIdOverClass() {
        let a = CSSSelector("#logo")
        let b = CSSSelector(".logo")
        XCTAssertTrue(a > b)
    }
    
    func testClassOverElement() {
        let a = CSSSelector(".logo")
        let b = CSSSelector("div")
        XCTAssertTrue(a > b)
    }

    func testMultipleSpecifities() {
        let a = CSSSelector("#logo .class")
        let b = CSSSelector("#logo div")
        XCTAssertTrue(a > b)
    }
    
}

//: [Next](@next)



























//: Unit Test Boilerplate (tricky to move to source files)

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
        let testSuite = tests.defaultTestSuite()
        testSuite.runTest()
        let run = testSuite.testRun as! XCTestSuiteRun
        
        print("Ran \(run.executionCount) tests in \(run.testDuration)s with \(run.totalFailureCount) failures")
    }
    
}

TestRunner().runTests(CSSSelectorTests)


