//: [Previous](@previous)


//: # Building a stack keeping track of max element

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

//: Protocol oriented style, 
//: We just need a type which is comparable

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

//: [Next](@next)
