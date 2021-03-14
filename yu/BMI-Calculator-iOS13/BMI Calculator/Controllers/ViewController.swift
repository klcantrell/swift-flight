import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightSlider.value = 1.50
        weightSlider.value = 100
        updateHeightLabel()
        updateWeightLabel()
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        updateHeightLabel()
    }

    @IBAction func weightSliderChanged(_ sender: UISlider) {
        updateWeightLabel()
    }
    
    @IBAction func calculateButtonClicked(_ sender: UIButton) {
        let weight = weightSlider.value
        let height = heightSlider.value
        let bmi = weight / (pow(height, 2))
        
        let resultViewController = ResultViewController(bmi: String(format: "%.2f", bmi))
        self.present(resultViewController, animated: true, completion: nil)
    }
    
    func updateHeightLabel() {
        let height = String(format: "%.2f", heightSlider.value)
        heightLabel.text = "\(height)m"
    }
    
    func updateWeightLabel() {
        let weight = String(format: "%.0f", weightSlider.value)
        weightLabel.text = "\(weight)Kg"
    }
}
