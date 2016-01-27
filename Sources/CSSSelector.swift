import Foundation

public struct CSSSelector {
    let selector: String
    
    public struct Specificity {
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

extension CSSSelector: Equatable {}

public func ==(lhs: CSSSelector, rhs: CSSSelector) -> Bool {
    // Naïve equality that uses string comparison rather than resolving equivalent selectors
    return lhs.selector == rhs.selector
}

// MARK: ## Let's make it Comparable

// MARK: ### Let's first make CSS specificity Equatable And comparable

extension CSSSelector.Specificity: Comparable {}

public func <(lhs: CSSSelector.Specificity, rhs: CSSSelector.Specificity) -> Bool {
    return lhs.id < rhs.id ||
        lhs.`class` < rhs.`class` ||
        lhs.element < rhs.element
}

extension CSSSelector.Specificity: Equatable {}


public func ==(lhs: CSSSelector.Specificity, rhs: CSSSelector.Specificity) -> Bool {
    return lhs.id == rhs.id &&
        lhs.`class` == rhs.`class` &&
        lhs.element == rhs.element
}

// MARK: ## Now we can make CSSSelector Comparable

extension CSSSelector: Comparable {}

public func <(lhs: CSSSelector, rhs: CSSSelector) -> Bool {
    return lhs.specificity < rhs.specificity
}