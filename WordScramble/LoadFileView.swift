//
//  LoadFileView.swift
//  WordScramble
//
//  Created by Gokhan Bozkurt on 23.04.2022.
//

import SwiftUI

struct LoadFileView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func loadFile() {
        if let fileURL = Bundle.main.url(forResource: "somefile", withExtension: "txt") {
            
            if let fileContents = try? String(contentsOf: fileURL) {
                // we loaded the file into a string!
            }
        }
    }
    
}

struct LoadFileView_Previews: PreviewProvider {
    static var previews: some View {
        LoadFileView()
    }
}
