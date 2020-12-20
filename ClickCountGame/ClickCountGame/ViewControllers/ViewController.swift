//
//  ViewController.swift
//  ClickCountGame
//
//  Created by Baris Berkin Tasci on 19.12.2020.
//

import UIKit

class ViewController: UIViewController, SecondViewControllerDelegate {
    
    // MARK: - OUTLETS
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var iconArea: UIImageView!
    
    let newPlayer = Player()
    
    // MARK: - LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUISV()
    }
    
    fileprivate func prepareUISV () {
        prepareStartButton()
        prepareHighscoreLabel()
        prepareResetButton()
        prepareInfoLabel()
    }
    
    fileprivate func prepareStartButton() {
        startButton.layer.cornerRadius = 10
        startButton.layer.masksToBounds = true
    }
    
    fileprivate func prepareHighscoreLabel() {
        highscoreLabel.layer.cornerRadius = 10
        highscoreLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        highscoreLabel.clipsToBounds = true
    }
    
    fileprivate func prepareResetButton() {
        resetButton.layer.cornerRadius = 10
        resetButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        resetButton.clipsToBounds = true
    }
    
    fileprivate func prepareInfoLabel() {
        infoLabel.layer.cornerRadius = 10
        infoLabel.layer.masksToBounds = true
    }
    
    // MARK: - ACTIONS
    @IBAction func startButtonTouched(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        secondViewController.delegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        let alertHowToPlay = UIAlertController(title: "How To Play", message: "Don't forget! Counter will start to count down when you touched 'Start!' button. Also enter your name above the click counter. Enjoy it!", preferredStyle: .alert)
        alertHowToPlay.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))
        self.present(alertHowToPlay, animated: true)
    }
    
    @IBAction func resetButtonTouched(_ sender: Any) {
        highscoreLabel.text = "No highscore has been saved yet!"
    }
    
    // MARK: - SECONDVIEWCONTROLLERDELEGATE METHODS
    func sendNewScore(newPlayer: Player) {
        highscoreLabel.text = "\(newPlayer.name) has the highest score: \(newPlayer.score)"
    }
}

