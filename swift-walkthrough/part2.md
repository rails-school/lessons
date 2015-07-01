# Swift walkthrough - Part 2

## Enums

```swift
enum Color {
    case Red // Unique value but you should not assume it is equal to 0
    case Blue
    case Green
}

var myColor = Color.Blue
var anotherColor: Color = .Red

switch myColor {
case .Red:
    // ...
case .Blue:
    // ...
case .Green:
    // Force to handle all cases if there is no default instruction
    // ...
}
```

```swift
enum Height {
    case American(Double, Double)
    case Universal(Double)
}

switch myHeight {
case .American(let feet, let inches):
    // ... Those guys are crazy
case .Universal(let centimeters):
    // ...
}
```

```swift
case NotificationPreference: Int {
    case Never = 0
    case OnlyIfAttending = 1
    case Always = 2
}

// Equivalent to
case NotificationPreference: Int {
    // Auto incrementation
    case Never = 0, OnlyIfAttending, Always
}
```

## Classes

```swift
class MyClass {
    var aField: Int
    var anotherField: String?
    
    init(anInt: Int) {
        aField = anInt
    }
    
    func aMethod() {
        self.aField++
        println("Called aMethod()")
    }
}

var anInstanceOfMyClass = MyClass(anInt: 90)
```

### Initializers

In Swift:

* All the fields **HAVE TO** be initialized, except optional ones. This should be done either by a direct assignment or within the constructor.
* When calling the constructor, you need to label all arguments.

```swift
class Degree {
    var value: Double
    
    // Designated initializer
    init(celsius: Double) {
        value = celsius
    }
    
    // Another designated initializer
    init(fahrenheit: Double) {
        value = (fahrenheit - 32) / 1.8
    }
    
    // Convenience initializer
    // An initializer is flagged as conveninent
    // if there is any call to another initializer.
    // Also, this call should be done before setting
    // any field
    convenience init(kelvins: Double) {
        self.init(celsius: kelvins - 273.15)
    }
    
    // Failable initializer. Returns an optional instance
    init?(fromString: String) {
        if fromString == "whatever" {
            return nil
        }
        
        value = (fromString as NSString).doubleValue
    }
}
```

### Properties

```swift
class Car {
    var distance: Double = 0 // Field
    var duration: Double = 0 // Typing could be implicit
    var _currentSpeed: Double = 0

    var averageSpeed: Double { // Read only property
        return distance /duration
    }
    
    var currentSpeed: Double { // Computed property
        get {
            return _currentSpeed
        }
        set(value) { 
            // Optional argument, directly available using
            // newValue
            _currentSpeed = value
        }
    }
    
    var name = "DefaultName" { // Define observers
        willSet { // Optional argument
            println("Will update name to \(newValue)")
        }
        didSet {
            println("Did update name, not anymore \(oldValue)")
        }
    }
}
```

### Methods

```swift
class Duck {
    func qwak() {
        println("Qwak Qwak")
    }
    
    func saySomething(s: String) {
        println("Seriously dude? Have you ever seen a speaking duck?")
    }
    
    func fly(duration: Double) {
        // ...
    }
    
    // For overloading a method, you need to have a different
    // argument label, even if types are different
    func fly(durationString: String) {
        // ...
    }
    
    // You can overload a method by changing the argument label 
    // for it is a part of the method signature
    func fly(distance: Double) {
        // ...
    }
    
    func methodWithManyArgs(a: Int, externalLabel b: String, c: Double) -> String {
        // In this scope, I can use a, b and c args
        
        // To call this function, I need to match this pattern:
        // myDuck.methodWithManyArgs(45, externalLabel: "bar", c: 90.87)        
        // First argument label is omitted, other ones are required
        return "foo"
    }
}
```

### Access control

* **Public**: Full access
* **Internal**: Relative to module
* **Private**: Relative to enclosing class

### Inheritance

```swift
class Animal {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func saySomething() {
        println("Default sound")
    }
}

class Duck: Animal {
   var age: Int

   init(name: String, age: Int) {
        // First step: initialize all child's members
        self.age = age
        
        // Once done, I can call the parent initializer
        super.init(name: name)
        
        // After the call, I can change the parent's fields
        // if needed. I cannot use them before
    }
    
    // Overidding parent's method
    override func saySomething() {
        println("Qwak!")
    }
}
```

This construction process ensures your class is not partially initialized before initializing the parent.

### Casting

```swift
class A {
}

class B: A {
}

class C {
}

var b = B()
var a1: A = b as! A // Force casting

var c = C()
var a2: A? = c as? A // Try casting, if failed, return nil

if b is A {
    // Test typing
}
```

## Structures

```swift
struct Point {
    var x: Double, y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}
```

Differences with classes:

* Structures are passed by value every time. Classes are passed by reference.
* Structures do not support inheritance.
* Structures have (usually) a lighter impact on memory performances.
* When initializing a structure, you can only have a single reference to it.
* Classes support casting.


## Closures

```swift
var closure = { (a: Int, b: String, c: Double) -> String in
    // ...
    return "foo"
}

// Equivalent to:
var closure: ((Int, String, Double) -> String) = { a, b, c in 
    // ...
    return "foo"
}

// Equivalent to:
var closure: ((Int, String, Double) -> String) = { _, _, _ in 
    // Use _ to ignore argument
    return "foo"
}

// Also equivalent to:
closure = {
    // You can use positional arguments
    // However you need to use all of them
    // in situations where their type is guessable
    // $0 == a
    // $1 == b
    // $2 == c
    return "foo"
}
```

```swift
func runAnimation(myObjectToAnimate: View, completion: () -> Void) {
    // ...
}

runAnimation(myObject, completion: {
    // Define here your completion handler
})

// Equivalent to:
runAnimation(myObject) {
    // Define here your completion handler
}
// When a closure is the latest argument, you can pass it as a trailing
// closure
```

As it is a closure, you can capture external variables inside your function. You can perform any operation on them.

**NB:** When using a closure within a class, you need to use the `self` keyword anytime you would like to use either a field or a method.

## Time to exercise

1. Create a `Person` class with those fields: `name` and `age`.
2. Create a `Player` and `Spectator` classes inheriting from `Person`. `Player` has an extra field named `gameNumber`, with a default value of 0.
3. Create a `Stadium` class with these fields: `name`, `capacity` and an optional `anthem`, which has the `Anthem` type. Add a convenience initializer setting the three properties in the same time.
4. Create a `Team` class pairing a stadium and a list of players.
5. Add a `playAgainst(anotherTeam: Team)` to the `Team` class. This method updates the `gameNumber` field from each player.

```swift
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class Player: Person {
    var gameNumber: Int
    
    override init(name: String, age: Int) {
        gameNumber = 0
        
        super.init(name: name, age: age)
    }
}

class Spectator: Person {
    override init(name: String, age: Int) {
        super.init(name: name, age: age)
    }
}

class Anthem {
}

class Stadium {
    var name: String
    var capacity: Int
    var anthem: Anthem?
    
    init(name: String, capacity: Int) {
        self.name = name
        self.capacity = capacity
    }
    
    convenience init(name: String, capacity: Int, anthem: Anthem) {
        self.init(name: name, capacity: capacity)
        
        self.anthem = anthem
    }
}

class Team {
    var stadium: Stadium
    var players: [Player]
    
    init(stadium: Stadium, players: [Player]) {
        self.stadium = stadium
        self.players = players
    }
    
    func playAgainst(anotherTeam: Team) {
        for e in players {
            e.gameNumber++
        }
        
        for e in anotherTeam.players {
            e.gameNumber++
        }
    }
}
```
