//
//  StringsView.swift
//  WordScramble
//
//  Created by Gokhan Bozkurt on 24.04.2022.
//

import SwiftUI

struct StringsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    func test() {
        //let input = "a b c"
       // let letters = input.components(separatedBy: " ")
        let input = """
                   a
                   b
                   c
                   """
       let letters = input.components(separatedBy: "\n")
       let letter = letters.randomElement()

       let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
       print(trimmed)


       let word = "swift"
       let checker = UITextChecker()
       let range = NSRange(location: 0, length: word.utf16.count)
       let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
       let allGood = misspelledRange.location == NSNotFound
       print(misspelledRange)

    }
}

struct StringsView_Previews: PreviewProvider {
    static var previews: some View {
        StringsView()
    }
}
