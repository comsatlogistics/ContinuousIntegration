//
//  GameDoneController.swift
//  Numerals
//
//  Created by Small Factory Studios on 11/30/19.
//  Copyright © 2019 Ray Dolber. All rights reserved.
//

import UIKit

class GameDoneController: UIViewController {
    
    private let bg: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gameOverLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "helvetica", size: 36)
        label.text = "Game over"
        label.textColor = UIColor.init(hexString: "#000000")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playAgainButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Play Again", for: .normal)
        button.titleLabel?.font = UIFont(name: "helvetia", size: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playAgainPressed), for: .touchUpInside)
        return button
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "helvetica", size: 24)
        label.text = "Score"
        label.textColor = UIColor.init(hexString: "#000000")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var score: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        compose()
        constrain()
        
        if let finalScore = score {
            scoreLabel.text = "Your final score: \(finalScore)"
        }
    }
    
    private func compose() {
        view.addSubview(bg)
        view.addSubview(gameOverLabel)
        view.addSubview(playAgainButton)
        view.addSubview(scoreLabel)
    }
    
    private func constrain() {
        bg.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        gameOverLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        gameOverLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        playAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playAgainButton.topAnchor.constraint(equalTo: gameOverLabel.bottomAnchor, constant: 50).isActive = true
        
        scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: playAgainButton.bottomAnchor, constant: 40).isActive = true
    }
    
    @objc func playAgainPressed(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
