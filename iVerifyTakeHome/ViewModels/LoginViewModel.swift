//
//  LoginViewModel.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-17.
//

import Foundation

struct LoginViewModel {
    func login(){
        AuthenticationService.shared.checkCredentials()
    }
}
