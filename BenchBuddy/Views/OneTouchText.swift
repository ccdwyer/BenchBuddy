//
//  OneTouchText.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/5/21.
//

import SwiftUI

struct OneTouchText: View {
    init(_ text: String) {
        self.text = text
    }
    var text: String
    
    @available(iOS 15, *)
    var formattedText: AttributedString {
        let markdownText = text
            .split(separator: " ")
            .map {
                string in
                let formattedString = string.components(separatedBy: CharacterSet.letters.inverted).joined()
                return "[\(string)](https://www.dictionary.com/browse/\(formattedString))"
            }
            .joined(separator: " ")
        return (try? AttributedString(markdown: markdownText)) ?? AttributedString()
    }
    
    var body: some View {
        if #available(iOS 15.0, *) {
            Text(formattedText)
                .tint(.primary)
        } else {
            Text(text)
            // Fallback on earlier versions
        }
    }
}

struct OneTouchText_Previews: PreviewProvider {
    static var previews: some View {
        OneTouchText("Hello World.")
    }
}
