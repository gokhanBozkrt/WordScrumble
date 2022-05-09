//
//  ContentView.swift
//  WordScramble
//
//  Created by Gokhan Bozkurt on 23.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    // Alert
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    // Score
     var score : Int {
        return usedWords.count 
    }
   
    
    
    var body: some View {
        NavigationView {
        
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .autocapitalization(.none)
                    }
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                    Image(systemName: "\(word.count).circle")
                                    Text(word)
                            }
                        }
                    }
                    
                    Section {
                      
                        withAnimation {
                            Text("Your score \(score)")
                        }
                     
                    }
                }
                .navigationTitle(rootWord)
                    .onSubmit {
                        addNewWord()
                    }
                    .onAppear {
                        startGame()
                        
                    }
                    .alert(errorTitle, isPresented: $showingError) {
                        Button("Ok", role: .cancel) { }
                    }
                    message: {
                        Text(errorMessage)
                    }
                    .toolbar {
                        Button("New Word", action : newGame)
                }
            
              
            }
         }
 
    func addNewWord() {
       let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard wordLength(answer) else {
            wordError("Short Word", "Must be at least 3 letters")
            return
        }
        guard isOriginal(answer) else {
            wordError("Word used before", "Be original")
            return
        }
        guard isPossible(answer) else {
            wordError("Word not possible", "You cant spell that word from '\(rootWord)'!")
            return
        }
        guard isReal(answer) else {
            wordError("Word not recognised", "Check if you write it truly")
            return
        }
        
     
        
        withAnimation {
            usedWords.insert(answer, at: 0)

        }
        newWord = ""
    }
    func startGame() {
        guard let wordUrl = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError("File not found")
        }
        guard let startWords = try? String(contentsOf: wordUrl) else {
            fatalError("Cuoldnt turn the file data object")
        }
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
        return
    }
    func isOriginal(_ word:String) -> Bool {
        !usedWords.contains(word)
    }
    func isPossible(_ word:String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    func isReal(_ word:String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return missRange.location == NSNotFound
    }
    func wordError(_ title:String, _ message:String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    // Disallow answers that are shorter than three letters or are just our start word.
    func wordLength(_ word:String) -> Bool {
        var tempWord = word
        return tempWord.count >= 3
    }
    func newGame() {
        startGame()
        usedWords.removeAll()
        newWord = ""
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
