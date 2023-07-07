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
    var characterButtons = [UIButton]()
    let characters = ["A", "B", "C", "D", "E", "F",
                      "G", "H", "I", "J","K", "L",
                      "M", "N", "O", "P", "Q", "R",
                      "S", "T", "U", "V", "W", "X",
                      "Y", "Z", "0", "1", "2", "3",
                      "4", "5", "6", "7", "8", "9"]

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


        let rows = 6
        let columns = 6

        let width = 65
        let height = 65
        var characterIndex = -1

        for row in 0..<rows {
            for column in 0..<columns {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = midFont
                letterButton.setTitle(characters[characterIndex + 1], for: .normal)
                characterIndex += 1
                letterButton.addTarget(self, action: #selector(characterTapped), for: .touchUpInside)

                let frame = CGRect(x: column * Int(width), y: row * height, width: Int(width), height: height)
                letterButton.frame = frame

                buttonsView.addSubview(letterButton)
                characterButtons.append(letterButton)
            }
        }


        let topAnchorLittleSpacerConstant = 20.0
        let topAnchorMidSpacerConstant = 100.0
        let availableSpace = UIScreen.main.bounds.height - levelLabel.frame.maxY - topAnchorMidSpacerConstant
        let widthAnchorSpacerMultiplier = 0.9

        NSLayoutConstraint.activate([
            levelLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

            scoreLabel.centerYAnchor.constraint(equalTo: levelLabel.centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

            quotationLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: min(topAnchorMidSpacerConstant, availableSpace)),
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
            buttonsView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.5),
            buttonsView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1),
        ])


    }


    override func viewDidLoad() {
        super.viewDidLoad()
        parseAndLoadLevel()
        loadLevelUI()


    }

    @objc func characterTapped(sender: UIButton) {
        guard let character = sender.title(for: .normal) else { return }

        let answer = answerStringArray[level]

        if answer.contains(character) == true {
            var updatedPlaceholder = String(currentAnswer.placeholder ?? "")
            for (index, placeholderChar) in answer.enumerated() {
                if placeholderChar == Character(character) {
                    let charIndex = updatedPlaceholder.index(updatedPlaceholder.startIndex, offsetBy: index)
                    updatedPlaceholder.replaceSubrange(charIndex...charIndex, with: String(character))
                }
            }
            currentAnswer.placeholder = updatedPlaceholder

            score += 1
        } else {
            score -= 1
        }
        sender.isHidden = true
    }

    var questionStringArray = [String]()
    var answerStringArray = [String]()
    var questionMarkArray = [String]()
    @objc func parseAndLoadLevel() {

        if let levelFileURL = Bundle.main.url(forResource: "levels", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()

                for line in lines {
                    let parts = line.components(separatedBy: ": ")
                    guard parts.count == 2 else { continue }
                    questionStringArray.append(parts[0])
                    answerStringArray.append(parts[1])
                    let questionMarks = String(repeating: "?", count: parts[1].count)
                    questionMarkArray.append(questionMarks)
                }
                print(questionStringArray)
                print(answerStringArray)
                print(questionMarkArray)
            }
        }
    }

    @objc func loadLevelUI() {
        quotationLabel.text = questionStringArray[level].trimmingCharacters(in: .whitespacesAndNewlines)
        currentAnswer.placeholder = questionMarkArray[level].trimmingCharacters(in: .whitespacesAndNewlines)

    }



}


