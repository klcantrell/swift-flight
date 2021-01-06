import UIKit

class ViewController: UIViewController {
    var countDownId = 0
    
    let softTime = 300
    let mediumTime = 420
    let hardTime = 720
    
    lazy var timeByHardness = ["Soft": softTime, "Medium": mediumTime, "Hard": hardTime]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let hardness = sender.title(for: .normal) else { return }
        guard let time = timeByHardness[hardness] else { return }
        
        countDownId = countDownId + 1
        titleLabel.text = "Time is a-ticking for a \(hardness) egg"
        countDown(from: time, id: countDownId)
    }
    
    func countDown(from remainingTime: Int, totalTime: Int? = nil, initialRun: Bool = true, id: Int) {
        guard id == countDownId else { return }
        
        let actualTotalTime = totalTime ?? remainingTime
        progressBar.progress = 1.0 - Float(remainingTime) / Float(actualTotalTime)
        
        guard remainingTime > 0 else {
            titleLabel.text = "ALL DONE!"
            return
        }
        
        let label = remainingTime == 1 ? "second" : "seconds"
        print("\(remainingTime) \(label)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.countDown(from: remainingTime - 1, totalTime: actualTotalTime, initialRun: false, id: id)
        }
    }
	
}
