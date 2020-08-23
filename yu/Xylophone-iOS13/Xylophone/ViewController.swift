import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    enum Note: String {
        case C = "C"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        playSound()
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: Note.C.rawValue, ofType: "wav") else { return }
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
