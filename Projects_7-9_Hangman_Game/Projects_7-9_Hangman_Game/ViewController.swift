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

    var questionStringArray = [String]()
    var answerStringArray = [String]()
    var questionMarkArray = [String]()

    var characterButtons = [UIButton]()
    let characters = ["A", "B", "C", "D", "E", "F",
                      "G", "H", "I", "J","K", "L",
                      "M", "N", "O", "P", "Q", "R",
                      "S", "T", "U", "V", "W", "X",
                      "Y", "Z", "0", "1", "2", "3",
                      "4", "5", "6", "7", "8", "9"]

    var level = 1 {
        didSet {
            levelLabel.text = "Level: \(level)"
        }
    }

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    var guessedCharacterCount = 0

    let ultraSmallFont = UIFont.systemFont(ofSize: 12)
    let smallFont = UIFont.systemFont(ofSize: 24)
    let midFont = UIFont.systemFont(ofSize: 36)
    let largeFont = UIFont.systemFont(ofSize: 48)

    let buttonsView = UIView()
    var lastQuestion = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(parseAndLoadGame), with: nil)
        performSelector(onMainThread: #selector(setupUI), with: nil, waitUntilDone: false)
        //TODO: perform in the main thread
        loadKeyBoard(buttonsView)
    }


    @objc func setupUI() {
        view = UIView()
        view.backgroundColor = .white

//        let buttonBorderWidth = 1.0
//        let buttonCornerRadius = 10.0
//        let buttonBorderColor = UIColor.lightGray.cgColor
//        let buttonHeight = 44.0
//        let buttonWidth = 154.0
//        let centerXAnchorButtonSpacerConstant = 100.0


        levelLabel = UILabel()
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.text = "Level: \(level)"
        levelLabel.font = smallFont
        levelLabel.textAlignment = .left
        view.addSubview(levelLabel)

        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font = smallFont
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)

        quotationLabel = UILabel()
        quotationLabel.translatesAutoresizingMaskIntoConstraints = false
        quotationLabel.text = questionStringArray[level - 1].trimmingCharacters(in: .whitespacesAndNewlines)
        quotationLabel.numberOfLines = 0
        quotationLabel.lineBreakMode = .byWordWrapping
        quotationLabel.font = midFont
        quotationLabel.textAlignment = .center
        view.addSubview(quotationLabel)

        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = questionMarkArray[level - 1].trimmingCharacters(in: .whitespacesAndNewlines)
        currentAnswer.font = largeFont
        currentAnswer.textAlignment = .center
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)

        let playerSlots = UILabel()
        playerSlots.translatesAutoresizingMaskIntoConstraints = false
        playerSlots.text = "Single player"
        playerSlots.font = smallFont
        playerSlots.textAlignment = .center
        view.addSubview(playerSlots)
//        playerSlots.layer.borderWidth = buttonBorderWidth
//        playerSlots.layer.cornerRadius = buttonCornerRadius
//        playerSlots.layer.borderColor = buttonBorderColor

        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)


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

            playerSlots.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: topAnchorLittleSpacerConstant),
            playerSlots.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            playerSlots.heightAnchor.constraint(equalToConstant: buttonHeight),
//            playerSlots.widthAnchor.constraint(equalToConstant: buttonWidth),

            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.5),
            buttonsView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1),
        ])


    }


    @objc func parseAndLoadGame() {

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
            }
        }
        lastQuestion = questionStringArray.last ?? "AAA"
    }

    //TODO: perform in the main thread
    @objc func loadKeyBoard(_ buttonsView: UIView) {

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
    }






    @objc func characterTapped(sender: UIButton) {

        guard let character = sender.title(for: .normal) else { return }
        let answer = answerStringArray[level - 1]
        var points = 0

        if answer.contains(character) == true {
            var updatedPlaceholder = String(currentAnswer.placeholder ?? "")
            for (index, placeholderChar) in answer.enumerated() {
                if placeholderChar == Character(character) {
                    let charIndex = updatedPlaceholder.index(updatedPlaceholder.startIndex, offsetBy: index)
                    updatedPlaceholder.replaceSubrange(charIndex...charIndex, with: String(character))
                    points += 1
                }
            }
            currentAnswer.placeholder = updatedPlaceholder
            score += points
            guessedCharacterCount += points
            points = 0
            sender.isHidden = true

            if guessedCharacterCount == answerStringArray[level - 1].count {
                nextLevel()
                sender.isHidden = false
                buttonsAppears()
            }
        } else {
            score -= 1
            sender.isHidden = true
        }
    }


    func nextLevel() {
        if questionStringArray[level - 1] == lastQuestion {
            lastLevelAlert()
        } else {
            guessedCharacterCount = 0
            level += 1
            nextLevelAlert()
            setupUI()
        }
    }

    func lastLevelAlert() {
        let ac = UIAlertController(title: "Congratulations!", message: "You passed all the game", preferredStyle: .alert)
        let reloadGame = UIAlertAction(title: "Reload game", style: .default) {
            [weak self] _ in
            self?.restartGame()
        }

        ac.addAction(reloadGame)
        present(ac, animated: true)
    }

    func nextLevelAlert() {
        let ac = UIAlertController(title: "Well done!", message: "Are you ready for level \(level)?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Let's go!", style: .default))
        present(ac, animated: true)
    }

    func buttonsAppears() {
        for button in characterButtons {
            button.isHidden = false
        }
    }

    @objc func restartGame() {
        level = 1
        score = 0
        guessedCharacterCount = 0
        levelLabel.text = "Level: \(level)"
        scoreLabel.text = "Score: \(score)"
        quotationLabel.text = "Guess my name? It's ease I think"
        currentAnswer.placeholder = "?????"

        for button in characterButtons {
            button.isHidden = false
        }

        // Clear any existing question and answer data
        questionStringArray.removeAll()
        answerStringArray.removeAll()
        questionMarkArray.removeAll()

        parseAndLoadGame()
        setupUI()
    }


}


