import UIKit

//var greeting = "Hello, playground"
//
//let calendar = Calendar.current
//let time = calendar.dateComponents([.hour, .minute, .second], from: Date())
//print(String(format: "%0.2d:%0.2d:%0.2d" ,time.hour!, time.minute!, time.second!))

let x = 1

switch x {
case 1:
	print(1)
	fallthrough
case 2: print(2)
case 3: print(3)
default: print("def")
}

var a = 1
var b = 2
print(a,b)
(a,b) = (b,a)
print(a,b)

