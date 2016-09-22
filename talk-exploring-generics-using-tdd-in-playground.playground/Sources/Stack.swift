
public class Stack<T> {
    public var items:[T]
    
    public init(){
        self.items = []
    }
    
    public func push(value:T) {
        items.append(value)
    }
    
    public func pop() -> T? {
        return items.popLast()
    }
    
    public func peek() -> T? {
        if items.count == 0 { return nil }
        return items[items.count - 1]
    }
}


