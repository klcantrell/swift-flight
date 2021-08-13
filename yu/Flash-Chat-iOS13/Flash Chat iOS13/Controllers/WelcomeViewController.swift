import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        let titleText = "⚡️FlashChat"
        for (characterIndex, letter) in titleText.enumerated() {
            Timer.scheduledTimer(withTimeInterval: Double(characterIndex) * 0.1, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
        }
    }
}
