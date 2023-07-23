import UIKit

var greeting = "Hello, playground"

let calendar = Calendar.current
let time = calendar.dateComponents([.hour, .minute, .second], from: Date())
print(String(format: "%0.2d:%0.2d:%0.2d" ,time.hour!, time.minute!, time.second!))
