//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    @IBOutlet weak var rollButtonView: UIButton!
    
    var leftDiceNumber = 1
    var rightDiceNumber = 5
    let diceImages = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rollButtonView.layer.cornerRadius = 5
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        diceImageView1.image = diceImages[min(leftDiceNumber, 5)]
        diceImageView2.image = diceImages[max(rightDiceNumber, 0)]
        leftDiceNumber += 1
        rightDiceNumber -= 1
    }
    
}
