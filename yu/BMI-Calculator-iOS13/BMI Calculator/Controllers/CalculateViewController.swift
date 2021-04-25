import UIKit

class CalculateViewController: UIViewController {
    
    var calculatorBrain = CalculatorBrain()
    
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
        
        calculatorBrain.calculateBMI(height: height, weight: weight)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func updateHeightLabel() {
        let height = String(format: "%.2f", heightSlider.value)
        heightLabel.text = "\(height)m"
    }
    
    func updateWeightLabel() {
        let weight = String(format: "%.0f", weightSlider.value)
        weightLabel.text = "\(weight)Kg"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationViewController = segue.destination as! ResultViewController
            destinationViewController.bmiValue = calculatorBrain.getBMIValue()
            destinationViewController.advice = calculatorBrain.getBMIAdvice()
            destinationViewController.color = calculatorBrain.getBMIColor()
        }
    }
}
