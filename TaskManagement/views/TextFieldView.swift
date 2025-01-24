//
//  TextFieldView.swift
//  TaskManagement
//
//  Created by Tina Thomsen on 23/01/2025.
//

import SwiftUICore
import SwiftUI

struct TextFieldView: View {
    @Binding var inputText: String
    var placeholder: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            field
                .padding(15)
                .foregroundColor(.fontBrown)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                    .stroke(.mountainBrown, lineWidth: 2)
                    .fill(.white)
                    .shadow(radius: 5)
                )
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private var field: some View {
        if isSecure {
            SecureField(placeholder, text: $inputText, prompt: Text(placeholder).foregroundColor(.mountainBrown))
        } else {
            TextField(placeholder, text: $inputText, prompt: Text(placeholder).foregroundColor(.mountainBrown))
        }
    }
}

