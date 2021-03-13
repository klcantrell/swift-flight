import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var storyBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI(
            story: storyBrain.nextStory(userChoice: nil)
        )
    }

    @IBAction func choiceButtonPressed(_ sender: UIButton) {
        updateUI(
            story: storyBrain.nextStory(userChoice: sender.currentTitle)
        )
    }
    
    func updateUI(story: Story) {
        storyLabel.text = story.title
        choice1Button.setTitle(story.choice1, for: .normal)
        choice2Button.setTitle(story.choice2, for: .normal)
    }
}

