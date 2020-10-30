import UIKit

class ViewController: UIViewController {
    var countDownId = 0
    
    let softTime = 3//300
    let mediumTime = 4//420
    let hardTime = 7//720
    
    lazy var timeByHardness = ["Soft": softTime, "Medium": mediumTime, "Hard": hardTime]
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let hardness = sender.title(for: .normal) else { return }
        guard let time = timeByHardness[hardness] else { return }
        
        countDownId = countDownId + 1
        titleLabel.text = "Time is a-ticking"
        countDown(from: time, initialRun: true, id: countDownId)
    }
    
    func countDown(from remainingTime: Int, initialRun: Bool, id: Int) {
        guard id == countDownId else { return }
        
        guard remainingTime > 0 else {
            titleLabel.text = "ALL DONE!"
            return
        }
        
        let label = remainingTime == 1 ? "second" : "seconds"
        print("\(remainingTime) \(label)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.countDown(from: remainingTime - 1, initialRun: false, id: id)
        }
    }
	
}
