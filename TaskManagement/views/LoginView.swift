//
//  LoginView.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import SwiftUICore
import SwiftUI

struct LoginView: View {
    @State var name: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextField("Username", text: $name)
                .padding(10)
        }
    }
}

struct previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
