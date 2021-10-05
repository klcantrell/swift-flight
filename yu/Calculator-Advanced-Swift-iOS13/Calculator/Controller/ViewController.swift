import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!

    private var calc: CalculatorLogic = CalculatorLogic()
    
    private var finishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        get {
            guard let displayText = displayLabel.text,
                  let number = Double(displayText) else {
                      fatalError("Cannot convert display label into a number")
                  }
            return number
        }
    }
    private var displayText: String {
        get {
            guard let displayText = displayLabel.text else {
                fatalError("Unable to retrieve text from display")
            }
            return displayText
        }
        set {
            displayLabel.text = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        finishedTypingNumber = true
        guard let calcMethodText = sender.currentTitle else {
            fatalError("Cannot process calculator method button")
        }
        if let result = calc.perform(operation: calcMethodText, value: displayValue) {
            let hasDecimal = displayText.contains(".")
            displayText = hasDecimal && result != 0 ? String(result) : String(Int(result))
        }
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        guard let numValue = sender.currentTitle else {
            fatalError("Cannot process number button")
        }
        if finishedTypingNumber {
            displayText = numValue
            finishedTypingNumber = false
        } else {
            if numValue == "." && displayText.contains(".") {
                return
            }
            displayText = displayText + numValue
        }
    }
}
