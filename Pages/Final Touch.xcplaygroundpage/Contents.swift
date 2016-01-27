//: [Previous](@previous)

//: And now let's spice up the sauce by mixing the two


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

extension CSSSelector: Equatable {}

func ==(lhs: CSSSelector, rhs: CSSSelector) -> Bool {
    // Naïve equality that uses string comparison rather than resolving equivalent selectors
    return lhs.selector == rhs.selector
}

extension CSSSelector.Specificity: Comparable {}

func <(lhs: CSSSelector.Specificity, rhs: CSSSelector.Specificity) -> Bool {
    return lhs.id < rhs.id ||
        lhs.`class` < rhs.`class` ||
        lhs.element < rhs.element
}

extension CSSSelector.Specificity: Equatable {}


func ==(lhs: CSSSelector.Specificity, rhs: CSSSelector.Specificity) -> Bool {
    return lhs.id == rhs.id &&
        lhs.`class` == rhs.`class` &&
        lhs.element == rhs.element
}

extension CSSSelector: Comparable {}

func <(lhs: CSSSelector, rhs: CSSSelector) -> Bool {
    return lhs.specificity < rhs.specificity
}

//: Let's try out our generic MaxStack with CSSSelector

import XCTest

class CSSMaxSelectorTests : XCTestCase {
    
    func testMaxSelector() {
        let stack = MaxStack<CSSSelector>()
        let a = CSSSelector("#logo")
        let b = CSSSelector("html body #logo")
        let c = CSSSelector("body div #logo")
        let d = CSSSelector(".container #logo")
        stack.push(a)
        stack.push(b)
        stack.push(c)
        stack.push(d)
        XCTAssertEqual(stack.getMax(), c)
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

TestRunner().runTests(CSSMaxSelectorTests)

//: [Next](@next)


