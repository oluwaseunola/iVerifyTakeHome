//
//  LoginView.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-17.
//

import SwiftUI

struct LoginView: View {
    @Binding var authenticated: Bool
    var authenticate : ()-> Void
    var viewModel: LoginViewModel = .init()
    var body: some View {
        ZStack{
            Color.white
            Button {
                viewModel.login()
                authenticated = true
                authenticate()
            } label: {
                Text("Login")
            }
        }

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authenticated: .constant(true), authenticate:{})
    }
}
