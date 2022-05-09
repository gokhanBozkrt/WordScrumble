//
//  ListView.swift
//  WordScramble
//
//  Created by Gokhan Bozkurt on 23.04.2022.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        List(0..<5) {
            Text("Dynamic row \($0)")
            /*
            Section("Section 1") {
                Text("Static row 1")
                Text("Static row 2")
            }

            Section("Section 2") {
                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
            }

            Section("Section 3") {
                Text("Static row 3")
                Text("Static row 4")
            }
             */
        }.listStyle(.grouped)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
