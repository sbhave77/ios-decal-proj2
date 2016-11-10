//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let phraseSoFar = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 70))

    let incorrectGuessesSoFar = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
    var globalPhrase = ""
    var canEnter = 1
    
    @IBOutlet weak var inputField: MaxLengthTextField!
    @IBOutlet weak var imagView: UIImageView!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var startOver: UIButton!
    
    override func viewDidLoad() {
        startOver.isEnabled = true
        super.viewDidLoad()
        imagView.image = #imageLiteral(resourceName: "hangman1.gif")
        canEnter = 1
//        startOver.isEnabled = false
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        globalPhrase = phrase!
        phraseSoFar.center = CGPoint(x: 160, y: 285 + 145)
        phraseSoFar.textAlignment = .center
        var temp = ""
        for i in (phrase!).characters{
            if (i == " ") {
                temp += "/" + " "
            } else {
                temp += "_" + " "
            }
        }
        phraseSoFar.text = temp
        phraseSoFar.lineBreakMode = NSLineBreakMode.byWordWrapping
        phraseSoFar.numberOfLines = 0

        incorrectGuessesSoFar.text = ""
        incorrectGuessesSoFar.center = CGPoint(x: 285 + 50, y: 145)
        
        inputField.maxLength = 1
                
        self.view.addSubview(phraseSoFar)
        self.view.addSubview(incorrectGuessesSoFar)
        guessButton.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        startOver.addTarget(self, action: #selector(restartTapped), for:
            UIControlEvents.touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func restartTapped(sender: UIButton) {
        viewDidLoad()
    }
    
    func buttonTapped(sender: UIButton) {
        
        var someInts = [Int]()
        
        let tryCharacter = inputField.text
        if (tryCharacter != nil && canEnter == 1) {
            if(globalPhrase.contains(tryCharacter!)) {
                for (i,c) in globalPhrase.characters.enumerated() {
                    if (c == Character(tryCharacter!)){
                        someInts.append(i)
                    }
                }
                var currentString = phraseSoFar.text!
                print(phraseSoFar.text!)
                print(globalPhrase)
                print(someInts)
                for i in someInts {
                    let currentIndex = currentString.startIndex
                    let globalIndex = globalPhrase.startIndex
                    let lo = currentString.index(currentIndex, offsetBy: 2*i)
//                    let hi = currentString.index(currentIndex, offsetBy: 2*(i+1))
                    let lo_global = globalPhrase.index(globalIndex, offsetBy: i)
                    currentString.remove(at: lo)
                    currentString.insert(globalPhrase[lo_global], at: lo)
//                    let subRange = lo ..< hi
//                    currentString = currentString.replacingCharacters(in: subRange, with: String(globalPhrase[lo_global]))
                }
                phraseSoFar.text = currentString
                if (!phraseSoFar.text!.contains("_")) {
                    let alert = UIAlertView(title: "WON!", message: "You have won the game!", delegate: nil, cancelButtonTitle: "Ok")
                    alert.delegate = self
                    alert.show()
                    canEnter = 0
                    startOver.isEnabled = true
                }
            } else {
                let currLen = incorrectGuessesSoFar.text!.characters.count
                var currGuesses = incorrectGuessesSoFar.text
                if (!currGuesses!.contains(tryCharacter!)) {
                    if (currLen == 0){
                        imagView.image = #imageLiteral(resourceName: "hangman2.gif")
                    } else if (currLen == 1) {
                        imagView.image = #imageLiteral(resourceName: "hangman3.gif")
                    } else if (currLen == 2) {
                        imagView.image = #imageLiteral(resourceName: "hangman4.gif")
                    } else if (currLen == 3) {
                        imagView.image = #imageLiteral(resourceName: "hangman5.gif")
                    } else if (currLen == 4) {
                        imagView.image = #imageLiteral(resourceName: "hangman6.gif")
                    } else if (currLen == 5) {
                        imagView.image = #imageLiteral(resourceName: "hangman7.gif")
                        let alert = UIAlertView(title: "LOST!", message: "You have lost the game!", delegate: nil, cancelButtonTitle: "Ok")
                        alert.delegate = self
                        alert.show()
                        canEnter = 0
                        startOver.isEnabled = true
                    }
                    currGuesses = currGuesses! + tryCharacter!
                    incorrectGuessesSoFar.text = currGuesses
                    print(currLen)
                }
                
//                let name = "./basic-hangman-img/hangman" + String(currLen + 1) + ".gif"
//                print(name)
//                let imag = UIImage(named: name)
//                print(imagView.image?.description)
                
            }
        }
        
    
    }
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
