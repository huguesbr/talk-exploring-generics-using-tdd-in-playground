public class MaxStack<T:Comparable> {
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

