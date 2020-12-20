//
//  Player.swift
//  ClickCountGame
//
//  Created by Baris Berkin Tasci on 19.12.2020.
//

class Player {
    
    var name: String = ""
    var score: Int = 0
    
    func getScore() -> Int {
        return score
    }
    func getName() -> String {
        return name
    }
    func setScore(newScore: Int) {
        score = newScore
    }
    func setName(newName: String) {
        name = newName
    }
}
