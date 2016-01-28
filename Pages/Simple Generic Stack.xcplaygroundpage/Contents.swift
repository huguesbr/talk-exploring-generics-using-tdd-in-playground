//: [Previous](@previous)
/*:

## Now, let's build a simple generic stack

Note that our generic stack will be a stack of any **homogeneous** type.

*/

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

//: [Next](@next)
