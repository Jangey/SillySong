//
//  ViewController.swift
//  Silly Song
//
//  Created by Jangey Lu on 6/24/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        let inputName: String = nameField.text!
        let shortName = shortNameFromName(name: inputName)
        //print(shortName)
        // join an array of strings into a single template string:
        let bananaFanaTemplate = [
            "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
            "Banana Fana Fo F<SHORT_NAME>",
            "Me My Mo M<SHORT_NAME>",
            "<FULL_NAME>"].joined(separator: "\n")
        
        let song: String = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: inputName, shortName: shortName)

        lyricsView.text = song
    }
}

func shortNameFromName(name: String) -> String {
    let lowercaseName = name.lowercased()
    let vowelSet : String = "aeiou"
    var shorterName: String = ""
    var hasVowel: Bool = false
    
    for index in lowercaseName.indices {
        print("\(lowercaseName[index]) ", terminator: "")
        let character : Character = lowercaseName[index]
        if (!hasVowel && vowelSet.contains(character)) {
            hasVowel = true
        }
        if (hasVowel) {
            shorterName.append(character)
        }
    }
    
    if (shorterName.isEmpty) {
        shorterName = name
    }
    return shorterName
}

func lyricsForName(lyricsTemplate: String, fullName: String, shortName: String) -> String {
    // ...
    var result : String = lyricsTemplate
    result = (result as NSString).replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    result = (result as NSString).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    return result
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
