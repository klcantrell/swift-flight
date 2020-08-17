import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ballView: UIImageView!
    @IBOutlet weak var askButtonView: UIButton!
    
    let ballArray = [#imageLiteral(resourceName: "ball1.png"),#imageLiteral(resourceName: "ball2.png"),#imageLiteral(resourceName: "ball3.png"),#imageLiteral(resourceName: "ball4.png"),#imageLiteral(resourceName: "ball5.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        askButtonView.layer.cornerRadius = 5
    }
    
    @IBAction func askButtonPressed(_ sender: UIButton) {
        print("Button pressed!")
    }
}
