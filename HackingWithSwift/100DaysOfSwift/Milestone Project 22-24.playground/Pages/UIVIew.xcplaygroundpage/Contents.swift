import UIKit
import PlaygroundSupport

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}


class Controller: UIViewController {
    override func viewDidLoad() {
        let newView = UIView()
        newView.backgroundColor = .red
        newView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view.addSubview(newView)
        newView.bounceOut(duration: 10)
    }
}

let controller = Controller()
PlaygroundPage.current.liveView = controller.view
