//
//  ViewController.swift
//  Project2
//
//  Created by Shah, Shubham on 19/02/20.
//  Copyright © 2020 Shubham shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(showScoreTapped))
        
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
    }

    func askQuestion(action:UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "Guess :: " +   countries[correctAnswer].uppercased() + " Current Score :: \(score)"
        questionsAnswered += 1
    }

    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var questionAnsweredCorrectly: Bool = false
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            questionAnsweredCorrectly = true
        }
        else {
            title = "Wrong"
            score -= 1
            questionAnsweredCorrectly = false
        }
        
        var ac = UIAlertController()
        
        if questionsAnswered == 10 {
            ac = UIAlertController(title: title, message: "Final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Game Over", style: .default, handler: askQuestion))
            score = 0
            correctAnswer = 0
            questionsAnswered = 0
            present(ac,animated: true)
        }
        else {
            if questionAnsweredCorrectly {
                ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            }
            else {
                ac = UIAlertController(title: title, message: "Thats the flag of \(countries[correctAnswer].uppercased()) Score :: \(score)", preferredStyle: .alert)
            }
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac,animated: true)
        }
    }
    
    @objc func showScoreTapped() {
        let ac = UIAlertController(title: "Current Score", message: "Your current score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac,animated: true)
    }
}

