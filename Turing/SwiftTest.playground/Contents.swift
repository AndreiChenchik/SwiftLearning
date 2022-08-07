import Combine
import Foundation
import CoreGraphics

let p = Publishers.Sequence<[Int], Error>(sequence: [1,4,8])
p.append([3,8,10])
    .filter { $0 >= 3}
    .count()

let allEven = p.tryAllSatisfy { $0 % 2 == 0 }
allEven.result

var x = 5

func increment() -> Int {
    defer { x += 1 }
    return x
}
print(x)

x = increment()
print(x)
let result = increment()
print(x, result, x)


protocol DrawingProtocol { func render() }
extension DrawingProtocol {
    func circle() { print("protocol") }
    func render () { circle() }
}

class SVG: DrawingProtocol {
    func circle() { print("class") }
}

SVG().render()


class BaseViewController {
    var view = "" {
        didSet {
            print("Base: \(view)")
        }
    }
}

class SubVC: BaseViewController {
    override var view: String {
        didSet {
            print("SubVC: \(view)")
        }
    }
}

let viewController = SubVC()
viewController.view = "x"
viewController.view = "y"


let nsString = NSString("Hello")
let swiftString = String(nsString)


var screen = CGRect(x: 0, y: 0, width: 320, height: 480) {
    didSet { print ("Screen changed") }
}
screen.origin.x = 30
var screen2 = screen
screen.size = CGSize(width: 20, height: 20)
screen2.origin.x = 10
screen.origin.x = 40

func XA(numberX: Int) {
    if numberX % 2 == 0 {
        defer { print("XA") }
        print("XB")
    } else {
        print("XC")
    }
    print ("XD")
}
XA(numberX: 4)

struct IntegralSize { var width: Int var height: Int }
