import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        let titleText = Constants.appName
        for (characterIndex, letter) in titleText.enumerated() {
            Timer.scheduledTimer(withTimeInterval: Double(characterIndex) * 0.1, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
        }
    }
}
