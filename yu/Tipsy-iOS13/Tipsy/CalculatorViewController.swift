import UIKit

class CalculatorViewController: UIViewController {
    
    var selectedTip: Float = 0.1
    var selectedSplitNumber: Int = 2
    var costPerPerson: Float = 0.0

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPercentButton: UIButton!
    @IBOutlet weak var tenPercentButton: UIButton!
    @IBOutlet weak var twentyPercentButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        if sender == zeroPercentButton {
            zeroPercentButton.isSelected = true
            tenPercentButton.isSelected = false
            twentyPercentButton.isSelected = false
            selectedTip = 0.0
        } else if sender == tenPercentButton {
            zeroPercentButton.isSelected = false
            tenPercentButton.isSelected = true
            twentyPercentButton.isSelected = false
            selectedTip = 0.1
        } else {
            zeroPercentButton.isSelected = false
            tenPercentButton.isSelected = false
            twentyPercentButton.isSelected = true
            selectedTip = 0.2
        }
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        selectedSplitNumber = Int(sender.value)
        splitNumberLabel.text = String(selectedSplitNumber)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        let total = Float(billTextField.text ?? "0.0") ?? 0.0
        let tipAmount = total * selectedTip
        costPerPerson = ((total + tipAmount) / Float(selectedSplitNumber) * 100).rounded() / 100
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationViewController = segue.destination as! ResultViewController
            destinationViewController.totalPerPerson = costPerPerson
            destinationViewController.splitNumber = selectedSplitNumber
            destinationViewController.tipValue = selectedTip
        }
    }

}

