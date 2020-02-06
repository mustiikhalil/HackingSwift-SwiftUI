//
//  Scramble.swift
//  Scramble
//
//  Created by Mustafa Khalil on 12/19/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation
import SwiftUI

class ScrambleViewModel: ObservableObject {
    
    var wordsCollections: [String] = []
    
    @Published var input = ""
    @Published var words: [String] = []
    @Published var selectedWord = ""
    @Published var errorShowed = false
    @Published var score = 0
    
    var errorMessage = ""
    
    func addNewWord() {
        let answered = input.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answered.count > 0 else { return }
        
        guard isOriginal else {
            presentError(message: "Be more original")
            return
        }
        guard isPossible else {
            presentError(message: "Some error")
            return
        }
        guard isAccepted else {
            presentError(message: "Word is the same or less than three")
            return
        }
        guard isReal else {
            presentError(message: "That's not a real world")
            return
        }
        words.append(answered)
        score += input.count
        input = ""
    }
    
    func startGame() {
        guard let file = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError("couldn't find start.txt")
        }
        guard let currentWords = try? String(contentsOf: file).components(separatedBy: "\n") else { return }
        wordsCollections = currentWords
        loadWord()
    }
    
    func loadWord() {
        words = []
        selectedWord = wordsCollections.randomElement() ?? "Skyrim"
    }
    
    func presentError(message: String) {
        errorMessage = message
        errorShowed = true
    }
    
    var isOriginal: Bool { !words.contains(input) }
    
    var isPossible: Bool {
        var tempWord = selectedWord.lowercased()
        for letter in input {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    var isAccepted: Bool {
        !(input == selectedWord) && input.count > 3
    }
    
    var isReal: Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: input.utf16.count)
        let misseplled = checker.rangeOfMisspelledWord(in: input, range: range, startingAt: 0, wrap: false, language: "en")
        return misseplled.location == NSNotFound
    }
    
}
