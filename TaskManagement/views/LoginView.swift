//
//  LoginView.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import SwiftUICore
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    func handleSignInTapped() {
        
    }
    
    var body: some View {
        ZStack {
            Color.deepOcean.ignoresSafeArea()
            ZStack() {
                Rectangle()
                    .fill(.bearBrown)
                    .frame(width: 320, height: 300)
                    .cornerRadius(20)
                    .overlay {
                        VStack(spacing: 20) {
                            Spacer()
                            Text(AppStrings.loginTitle)
                                .font(.title)
                                .foregroundColor(.darkBrown)
                                .bold()
                            
                            TextFieldView(placeholder: AppStrings.usernamePlaceholder, inputText: $username)
                            TextFieldView(placeholder: AppStrings.passwordPlaceholder, inputText: $password, isSecure: true)
                            
                            Button(action: handleSignInTapped) {
                                Text(AppStrings.loginBtn)
                                    .font(.callout.bold())
                                    .padding()
                                    .background(Color.shallowWater)
                                    .foregroundColor(.cream)
                                    .cornerRadius(20)
                                    .shadow(radius: 5)
                            }
                            Spacer()
                        }
                        .padding()
                    }
            }
        }
    }
}

struct previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

