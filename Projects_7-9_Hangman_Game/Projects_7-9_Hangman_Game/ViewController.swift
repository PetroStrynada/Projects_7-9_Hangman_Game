//
//  ViewController.swift
//  Projects_7-9_Hangman_Game
//
//  Created by Petro Strynada on 06.07.2023.
//

import UIKit

class ViewController: UIViewController {
    var levelLabel: UILabel!
    var scoreLabel: UILabel!
    var quotationLabel: UILabel!
    var currentAnswer: UITextField!
    var letterButtons = [UIButton]()

    var level = 0 {
        didSet {
            levelLabel.text = "Level: \(level)"
        }
    }

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        let ultraSmallFont = UIFont.systemFont(ofSize: 12)
        let smallFont = UIFont.systemFont(ofSize: 24)
        let midFont = UIFont.systemFont(ofSize: 36)
        let largeFont = UIFont.systemFont(ofSize: 48)

        let buttonBorderWidth = 1.0
        let buttonCornerRadius = 10.0
        let buttonBorderColor = UIColor.lightGray.cgColor
        let buttonHeight = 44.0
        let buttonWidth = 88.0
        let centerXAnchorButtonSpacerConstant = 100.0

        let topAnchorLittleSpacerConstant = 20.0
        let topAnchorMidSpacerConstant = 100.0
        let widthAnchorSpacerMultiplier = 0.9

        levelLabel = UILabel()
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.text = "Level: 1"
        levelLabel.font = smallFont
        levelLabel.textAlignment = .left
        view.addSubview(levelLabel)

        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: 0"
        scoreLabel.font = smallFont
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)

        quotationLabel = UILabel()
        quotationLabel.translatesAutoresizingMaskIntoConstraints = false
        quotationLabel.text = "Guess my name? It's ease I think"
        quotationLabel.numberOfLines = 0
        quotationLabel.lineBreakMode = .byWordWrapping
        quotationLabel.font = midFont
        quotationLabel.textAlignment = .center
        view.addSubview(quotationLabel)

        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "?????"
        currentAnswer.font = largeFont
        currentAnswer.textAlignment = .center
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)

        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        //submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        submit.layer.borderWidth = buttonBorderWidth
        submit.layer.cornerRadius = buttonCornerRadius
        submit.layer.borderColor = buttonBorderColor

        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        //clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        clear.layer.borderWidth = buttonBorderWidth
        clear.layer.cornerRadius = buttonCornerRadius
        clear.layer.borderColor = buttonBorderColor

        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)

        let width = 65
        let height = 65

        for row in 0..<6 {
            for column in 0..<6 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = midFont
                letterButton.setTitle("W", for: .normal)
                //letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)

                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame

                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }


        NSLayoutConstraint.activate([
            levelLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

            scoreLabel.centerYAnchor.constraint(equalTo: levelLabel.centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

            quotationLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: topAnchorMidSpacerConstant),
            quotationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quotationLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: widthAnchorSpacerMultiplier),

            currentAnswer.topAnchor.constraint(equalTo: quotationLabel.bottomAnchor, constant: topAnchorLittleSpacerConstant),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: widthAnchorSpacerMultiplier),

            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: topAnchorLittleSpacerConstant),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -centerXAnchorButtonSpacerConstant),
            submit.heightAnchor.constraint(equalToConstant: buttonHeight),
            submit.widthAnchor.constraint(equalToConstant: buttonWidth),

            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerXAnchorButtonSpacerConstant),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: buttonHeight),
            clear.widthAnchor.constraint(equalToConstant: buttonWidth),

            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: topAnchorLittleSpacerConstant),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            buttonsView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.5),
            buttonsView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1)
        ])


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }



}

