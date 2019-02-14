//
//  ViewController.swift
//  BullsEye
//
//  Created by Gokhan Ozturk on 1.01.2019.
//  Copyright © 2019 devops.istanbul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentSliderValue: Int = 0 // Initial value of the slider is 0 if the slider has never been moved
    var targetValue: Int = 0
    var currentRound: Int = 0
    var currentScore: Int = 0
    var totalScore: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentSliderValue = Int(slider.value.rounded())
        startOver()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    @IBAction func showAlert(){
        
        let difference: Int = calculateScore()
        let title = prepareAlertTitle(difference)
        
        let message = "Selected value is \(currentSliderValue), target is \(targetValue)" +
                        "\nYou scored \(currentScore) at this round!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Well Done!", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentSliderValue = Int(slider.value.rounded())
    }
    
    func startNewRound(){
        targetValue = Int.random(in: 1...100)
        currentRound += 1
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
        updateLabels()
    }
    
    func updateLabels(){
        targetValueLabel.text = String(targetValue)
        roundLabel.text = String(currentRound)
        scoreLabel.text = String(totalScore)
    }
    
    func calculateScore() -> Int{
        let difference = abs(currentSliderValue - targetValue)
        
        if difference == 0 {
            currentScore = 200
        } else if difference == 1 {
            currentScore = 150
        } else {
            currentScore = 100 - difference
        }
        
        totalScore += currentScore
        return difference
    }
    
    func prepareAlertTitle(_ difference: Int) -> String {
        let title: String?
        
        switch difference {
            case 0:
                title = "Bulls Eye!\nAdditional 100 Bonus Points!"
            case 1..<2:
                title = "Awesome!\nAdditional 50 Bonus Points!"
            case 2..<10:
                title = "Could Be Better!"
            case 10...100:
                title = "Not Even Close!"
            default:
                title = "Keep Trying!"
        }
        return title!
    }
    
    @IBAction func startOver(){
        totalScore = 0
        currentRound = 0
        startNewRound()
    }

}

