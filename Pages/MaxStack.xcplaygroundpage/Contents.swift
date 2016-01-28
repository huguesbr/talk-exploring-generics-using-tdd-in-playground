//: [Previous](@previous)
/*:

# Building a stack keeping track of max element using Protocol oriented programming

In order to keep track of a max item, we just need a way to compare them.
Luckily we can express this using generics.

Generics allow to express protocol requirement.
(You could do this in Objective-C using `id<SomeProtocol>`)

Swift have declare equivalency and comparaison using protocol, not possible in Obj-C (Also, thanks to operator overloading...)
So we can express the **comparable requirement** in our generics implementation.

Also, the homogeneous requirement of Generics allows us to avoid comparing Apple and Robot...

*/

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

//: We should have some tests for this...

//: [Next](@next)
