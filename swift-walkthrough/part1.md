# Swift walkthrough

## Var declarations

```swift
var aBool = true
let myString: String = "foo"
var aInt = 56

myString = "bar" // Error
```

Basic types: Bool, Int, Double, Float, String

## Optionals

```swift
var i: Int? // current value = nil
var b: Bool?

var s: String // Compile error

// Test if value is different than nil
if let aBool = b {
    // ...
}

if b! { // Runtime error if nil
    // ...
}
```

**All non optional variables must have a value.**

## Arrays / Dictionaries / Tuples

```swift
var anArray: [Int] = [1, 2, 3]
var emptyArray = [Int]()

var aDictionary: [String: String?] = [
    "foo": nil,
    "bar": "barfoo"
]
var emptyDictionary: [String: String?] = [:]

let e = anArray[2] // e = 3
let s = aDictionary["foo"] // s = nil
```

```swift
var t: (firstElement: Int, secondElement: String) = (firstElement: 3, secondElement: "foo")

// t.firstElement = 3

let (a, b) = t
// a = 3
// b = "foo"

var e = (200, "ok")
// e.1 = "ok"
```

## Conditions

```swift
if myBool && myArray[3] == 89 {
    // ...
} else if myArray[0] < 67 || myArray[1] > 0 {
    // ...
} else {
    // ...
}
```

```swift
switch (myValue) {
    case 0:
        // Do some stuff
    case 1:
        // Another stuff
        // In Swift, break keyword is optional.
        // If you would like to run cascade cases, use fallthrough keyword
    default:
        // Default case
        break // No instruction, so I need a break
}
```

## Loops

```swift
while myBool {
    // ...
}

do {
    // ...
} while myCondition
```

```swift
for var i = 0; i < 100; i++ {
    // ...
}

for i in 0...99 {
    // ...
}

for i in 0..<100 {
    // ...
}
```

```swift
for e in [1, 2, 3] {
    // ...
}

for (a, b) in ["foo": 3, "bar": 4] {
    // ...
}

for c in "Foo" {
    // ...
}
```

## Functions

```swift
func myFunc(arg1: Int, arg2: String) -> Bool {
    return true
}

myFunc(4, arg2: "foo") // Error if not a method
myFunc(4, "foo") // Error if method
```

```swift
func myFunc(externalName internalArg: String, secondExternalName secondInternalName: String) {
    // ...
}

myFunc("foo", secondExternalName: "bar")
myFunc("foo", secondInternalName: "bar") // Error
myFunc(externalName: "foo", secondExternalName: "bar") // Error
```

## Exercices

### Sheep array

Array of bool => Returns number of true in that array

```swift
func sheepArray(a: [Bool]) -> Int {
    var i = 0
    for e in a {
        if e {
            i++
        }    
    }
    
    return i
}
```

### Array difference

```swift
func diff(a: [Int], b: [Int]) -> [Int] {
    var outcome = [Int]()
    
    for i in a {
        var isInB = false
        for j in b {
            if i == j {
                isInB = true
            }
        }
        
        if !isInB {
            outcome.append(i)
        }
    }
    
    return outcome
}
```

### Dictionary selection

```swift
func select(d: [String: String], f: (String, String) -> Bool) -> [String: String] {
    var outcome: [String: String] = [:]
    
    for (key, value) in d {
        if f(key, value) {
            outcome[key] = value
        }
    }
    
    return outcome
}
```

### Turkish social security number

Every Turkish citizen has an identity number whose validity can be checked by these set of rules:

* It is an 11 digit number
* First digit can't be zero
* Take the sum of 1st, 3rd, 5th, 7th and 9th digit and multiply it by 7. Then subtract the sum of 2nd, 4th, 6th and 8th digits from this value. Modulus 10 of the result should be equal to 10th digit.
* Sum of first ten digits' modulus 10 should be equal to eleventh digit.

```swift
extension String {
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }

    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
}

func checkValidTurkishNumber(n: Int) -> Bool {
    if n <= 0 {
        println("Negative number")
        return false
    }

    var s = String(n)
    if count(s) != 11 {
        println("Invalid size")
        return false
    }

    if s[0].toInt()! == 0 {
        println("First number is a zero")
        return false
    }

    var a = (s[0].toInt()! + s[2].toInt()! + s[4].toInt()! + s[6].toInt()! + s[8].toInt()!) * 7
    a -= (s[1].toInt()! + s[3].toInt()! + s[5].toInt()! + s[7].toInt()!)

    if a % 10 != s[9].toInt()! {
        println("Computation does not match 10th number")
        return false
    }

    var b = 0
    for i in 0..<count(s) {
        if i < 10 {
            b += s[i].toInt()!
        }
    }

    return b % 10 == s[10].toInt()!
}
```
