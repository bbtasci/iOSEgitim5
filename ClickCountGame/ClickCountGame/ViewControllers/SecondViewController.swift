//
//  SecondViewController.swift
//  ClickCountGame
//
//  Created by Baris Berkin Tasci on 19.12.2020.
//

import UIKit

protocol SecondViewControllerDelegate {
    func sendNewScore(newPlayer: Player)
}

class SecondViewController: UIViewController {
    
    var score = 0
    var highscore: Int = 0
    var name: String = ""
    var timer: Timer?
    var timeLeft = 60
    var newPlayer = Player()
    
    var delegate: SecondViewControllerDelegate?

    // MARK: - OUTLETS
    @IBOutlet weak var iconSecondArea: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var clickMeButton: UIButton!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var counterLabel: UILabel!
    
    // MARK: - LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    fileprivate func prepareUI() {
        prepareTimerLabel()
        prepareStartGameButton()
        prepareNameField()
        prepareClickMeButton()
        prepareCounterLabel()
    }
    
    fileprivate func prepareTimerLabel() {
        timerLabel.layer.cornerRadius = 10
        timerLabel.layer.masksToBounds = true
    }

    fileprivate func prepareStartGameButton() {
        startGameButton.layer.cornerRadius = 10
        startGameButton.layer.masksToBounds = true
    }
    
    fileprivate func prepareNameField() {
        nameField.layer.cornerRadius = 10
        nameField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        nameField.clipsToBounds = true
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = UIColor.black.cgColor
    }
    
    fileprivate func prepareClickMeButton() {
        clickMeButton.layer.cornerRadius = 10
        clickMeButton.layer.masksToBounds = true
    }
    
    fileprivate func prepareCounterLabel() {
        counterLabel.layer.cornerRadius = 10
        counterLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        counterLabel.clipsToBounds = true
    }
    
    func notStartWithoutName() {
        if nameField.text == "" {
            let alertEnterName = UIAlertController(title: "Warning!", message: "Please enter name before starting.", preferredStyle: .alert)
            alertEnterName.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertEnterName, animated: true)}
    }
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timeLeft > -1 {
                self.timerLabel.text = ("\(self.timeLeft) seconds left!")
                self.timeLeft -= 1
            } else {
                self.stopTimer()
                self.showHighscoreAlert()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func showHighscoreAlert() {
        if score > highscore{
            highscore = score
            let alertNewHighscore = UIAlertController(title: "Congratulations!", message: "You scored the highest!", preferredStyle: .alert)
            alertNewHighscore.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.sendNewScore(newPlayer: self.newPlayer)
            }))
            self.present(alertNewHighscore, animated: true)
        }
    }
    
    @IBAction func startGameButtonTouched(_ sender: Any) {
        notStartWithoutName()
        if nameField.text != "" {
            startTimer()
        }
    }
    
    @IBAction func clickMeButtonTouched(_ sender: Any) {
        if timeLeft <= 60 && timeLeft > 0 {
            score += 1
            counterLabel.text = "clicked \(score) times"
        }
        if timeLeft == -1 {
        }
    }
    
    // MARK: SEND NEW SCORE
    func sendNewScore(newPlayer: Player) {
        newPlayer.setScore(newScore: score)
        newPlayer.setName(newName: nameField.text ?? "")
        self.delegate?.sendNewScore(newPlayer: newPlayer)
        self.navigationController?.popViewController(animated: true)
    }
}
