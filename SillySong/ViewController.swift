//
//  ViewController.swift
//  SillySong
//
//  Created by David Della Vecchia on 6/15/17.
//  Copyright © 2017 QubitLogic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    func shortNameFromName(name: String) -> String {
        let lowercaseName = name.lowercased()
        let vowelSet = CharacterSet(charactersIn: "aeiou")
        
        let index = lowercaseName.rangeOfCharacter(from: vowelSet)
        
        if let index = index {
            return lowercaseName.substring(from: index.lowerBound)
        }
        return lowercaseName
    }

    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        let shortName = shortNameFromName(name: fullName)
        let lyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        return lyrics.replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    }
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    @IBAction func displayLyrics(_ sender: Any) {
        guard let name = nameField.text, !name.isEmpty else {
            return
        }
        
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

}

