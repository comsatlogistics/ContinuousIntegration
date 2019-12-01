//
//  ViewController.swift
//  Numerals
//
//  Created by Small Factory Studios on 11/30/19.
//  Copyright © 2019 Ray Dolber. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private let converterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "helvetica", size: 36)
        label.text = "↓"
        label.textColor = UIColor.init(hexString: "#CCCCCC")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bg: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let falseButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("❌", for: .normal)
        button.titleLabel?.font = UIFont(name: "helvetia", size: 48)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(choiceButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "helvetica", size: 36)
        label.text = "3999"
        label.textColor = UIColor.init(hexString: "#3399FF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let romanNumeralLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "helvetica", size: 36)
        label.text = "MMMCMXCIX"
        label.textColor = UIColor.init(hexString: "#3366FF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "helvetica", size: 17)
        label.text = "0 / 10"
        label.textColor = UIColor.init(hexString: "#333333")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "helvetica", size: 24)
        label.text = "Is this conversion correct?"
        label.textColor = UIColor.init(hexString: "#000000")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trueButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("✔️", for: .normal)
        button.titleLabel?.font = UIFont(name: "helvetia", size: 48)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(choiceButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var game: Game?
    var score: Int? {
        didSet {
            if let score = score, let game = game {
              scoreLabel.text = "\(score) / \(game.maxAttemptsAllowed)"
            }
        }
    }
    var originalIndicatorColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        compose()
        constrain()
        
        game = Game()
        originalIndicatorColor = converterLabel.textColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        game?.reset()
        score = game?.score
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNextPlay()
    }
    
    private func compose() {
        view.addSubview(bg)
        view.addSubview(scoreLabel)
        view.addSubview(titleLabel)
        view.addSubview(numberLabel)
        view.addSubview(converterLabel)
        view.addSubview(romanNumeralLabel)
        view.addSubview(falseButton)
        view.addSubview(trueButton)
    }
    
    private func constrain() {
        bg.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        numberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        converterLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 20).isActive = true
        converterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        romanNumeralLabel.topAnchor.constraint(equalTo: converterLabel.bottomAnchor, constant: 20).isActive = true
        romanNumeralLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        falseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        falseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        falseButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        falseButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        trueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        trueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        trueButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        trueButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    @objc private func choiceButtonPressed(_ sender: UIButton) {
        if sender == falseButton {
            play(false)
        } else if sender == trueButton {
            play(true)
        }
    }
    
    private func showNextPlay() {
        guard let game = game else { return }
        if !game.done() {
          let (question, answer) = game.showNextPlay()
          numberLabel.text = "\(question)"
          romanNumeralLabel.text = answer
          converterLabel.textColor = originalIndicatorColor
          controlsEnabled(true)
          // Show info
          UIView.animate(withDuration: 0.5) {
            self.numberLabel.center.x += self.view.bounds.width
            self.romanNumeralLabel.center.x -= self.view.bounds.width
            self.converterLabel.alpha = 1.0
          }
        }
    }
    
    private func controlsEnabled(_ on: Bool) {
        falseButton.isEnabled = on
        trueButton.isEnabled = on
    }
    
    private func play(_ selection: Bool) {
        controlsEnabled(false)
        if let result = game?.play(selection) {
            score = result.score
            displayResults(result.correct)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
            if (self.game?.done())! {
                print("GAME DONE")
                self.showGameDone()
            } else {
                // Clear info
                UIView.animate(withDuration: 0.5, animations: {
                    self.numberLabel.center.x -= self.view.bounds.width
                    self.romanNumeralLabel.center.x += self.view.bounds.width
                    self.converterLabel.alpha = 0.0
                }, completion: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        self.showNextPlay()
                    }
                })
            }
        }
    }
    
    private func showGameDone() {
        let gameController = GameDoneController()
        gameController.score = score
        gameController.modalPresentationStyle = .fullScreen
        present(gameController, animated: true, completion: nil)
    }
    
    private func displayResults(_ correct: Bool) {
      if correct {
        print("You answered correctly!")
        converterLabel.textColor = .green
      } else {
        print("That one got you.")
        converterLabel.textColor = .red
      }
      // Visual indicator of correctness
      UIView.animate(withDuration: 0.5, animations: {
        self.converterLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
      }, completion: { _ in
        UIView.animate(withDuration: 0.5) {
          self.converterLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
      })
    }
}
