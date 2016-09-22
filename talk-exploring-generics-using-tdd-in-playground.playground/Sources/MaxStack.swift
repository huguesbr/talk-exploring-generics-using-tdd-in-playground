public class MaxStack<T:Comparable> {
    public var items:Stack<T>
    public var maxStack:Stack<T>
    
    public init(){
        self.items = Stack<T>()
        self.maxStack = Stack<T>()
    }
    
    public func push(value:T) {
        if let maxValue = maxStack.peek() {
            if(value >= maxValue) {
                maxStack.push(value)
            }
        } else {
            maxStack.push(value)
        }
        items.push(value)
    }
    
    public func pop() -> T? {
        guard let value = items.pop() else { return nil }
        if let maxValue = maxStack.peek() {
            if(value == maxValue) { maxStack.pop() }
        }
        return value
    }
    
    public func peek() -> T? {
        return items.peek()
    }
    
    public func getMax() -> T? {
        return maxStack.peek()
    }
}