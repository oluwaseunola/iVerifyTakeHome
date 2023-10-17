//
//  SearchBar.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-17.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search by name or device.", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, 8)
            
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.blue)
                    .opacity(text.isEmpty ? 0 : 1)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 8)
        }
        .padding(.vertical, 8)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(8)
    }
}






