import UIKit

class ResultViewController: UIViewController {
    
    var totalPerPerson: Float?
    var splitNumber: Int?
    var tipValue: Float?

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let totalFormatted = String(format: "%.2f", totalPerPerson ?? "0.0")
        let tipFormatted = String(format: "%.0f", (tipValue ?? 0.0) * 100)
        
        totalLabel.text = totalFormatted
        settingsLabel.text = "Split between \(splitNumber ?? 2) people, with \(tipFormatted)% tip"
    }
    
    @IBAction func recalculatePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
