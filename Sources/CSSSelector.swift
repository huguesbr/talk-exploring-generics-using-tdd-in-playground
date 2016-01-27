import Foundation


public struct CSSSelector {
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
    
    public init(_ string: String) {
        self.selector = string
        
        // Naïve tokenization, ignoring operators, pseudo-selectors, and `style=`.
        let components: [String] = self.selector.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        self.specificity = Specificity(components)
    }
}

extension CSSSelector: Equatable {}

public func ==(lhs: CSSSelector, rhs: CSSSelector) -> Bool {
    // Naïve equality that uses string comparison rather than resolving equivalent selectors
    return lhs.selector == rhs.selector
}

extension CSSSelector.Specificity: Comparable {}

func <(lhs: CSSSelector.Specificity, rhs: CSSSelector.Specificity) -> Bool {
    let result = lhs.id < rhs.id ||
        lhs.id == rhs.id && lhs.`class` < rhs.`class` ||
        lhs.id == rhs.id && lhs.`class` == rhs.`class` && lhs.element < rhs.element
    
    return result
}

extension CSSSelector.Specificity: Equatable {}


func ==(lhs: CSSSelector.Specificity, rhs: CSSSelector.Specificity) -> Bool {
    return lhs.id == rhs.id &&
        lhs.`class` == rhs.`class` &&
        lhs.element == rhs.element
}

extension CSSSelector: Comparable {}

public func <(lhs: CSSSelector, rhs: CSSSelector) -> Bool {
    return lhs.specificity < rhs.specificity
}