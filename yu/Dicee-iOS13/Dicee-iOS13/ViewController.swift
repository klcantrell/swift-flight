import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    @IBOutlet weak var rollButtonView: UIButton!
    
    let diceImages = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rollButtonView.layer.cornerRadius = 5
        randomizeDiceImageSource(diceImageView1)
        randomizeDiceImageSource(diceImageView2)
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        randomizeDiceImageSource(diceImageView1)
        randomizeDiceImageSource(diceImageView2)
    }
    
    func randomizeDiceImageSource(_ diceImage: UIImageView) {
        diceImage.image = diceImages.randomElement()
    }
    
}
