import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    enum Note: String {
        case C = "C"
        case D = "D"
        case E = "E"
        case F = "F"
        case G = "G"
        case A = "A"
        case B = "B"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        let noteName = Note(rawValue: sender.currentTitle!)!
        playSound(noteName)
        UIView.animate(withDuration: 0.2, animations: {
            sender.alpha = 0.5
        }) { (completed) in
            UIView.animate(withDuration: 0.2, animations: {
                sender.alpha = 1
            })
        }
    }
    
    func playSound(_ noteName: Note) {
        guard let path = Bundle.main.path(forResource: noteName.rawValue, ofType: "wav") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
