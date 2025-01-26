//
//  LoginView.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import SwiftUICore
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @EnvironmentObject var router: Router
    
    init() {
        _viewModel = StateObject(wrappedValue: LoginViewModel(dataService: DataService()))
    }
    
    func handleLoginTap() {
        Task {
                withAnimation {
                    viewModel.isLoading = true
                }
                await viewModel.handleLoginFlow()
                withAnimation {
                    viewModel.isLoading = false
                }
            }
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
                            Text(AppStrings.Login.loginTitle)
                                .font(.title)
                                .foregroundColor(.darkBrown)
                                .bold()
                            
                            TextFieldView(inputText: $viewModel.username, placeholder: AppStrings.Login.usernamePlaceholder)
                            TextFieldView(inputText: $viewModel.password, placeholder: AppStrings.Login.passwordPlaceholder, isSecure: true)
                            
                            if let errorMessage = viewModel.errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .padding()
                            } else {
                                Button(action: handleLoginTap) {
                                    Text(AppStrings.Login.loginBtn)
                                        .font(.callout.bold())
                                        .padding()
                                        .background(Color.shallowWater)
                                        .foregroundColor(.cream)
                                        .cornerRadius(20)
                                        .shadow(radius: 5)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
            }
        }
    }
}

struct login_previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SessionManager.shared)
            .environmentObject(Router())
    }
}
