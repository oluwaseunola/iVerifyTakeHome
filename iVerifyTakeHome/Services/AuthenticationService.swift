//
//  AuthenticationService.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-13.
//

import Foundation
/// This is a fake auth class that mocks the return of a token after a user would log in
final class AuthenticationService {
    
    static let shared = AuthenticationService()
    private var queue = DispatchQueue(label: "saveToken")
    
    private init() {}
    
    func checkCredentials(){
    //Here authentication would be done and a token returned which we save to Keychain
        queue.async {
            KeychainService.saveToken(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBdXRoZW50aWNhdGlvbiIsImlzcyI6ImlWZXJpZnkiLCJ1c2VySWQiOjYyLCJleHAiOjE3MjUxMjg5Mjl9.Vzy-WfuNVplsuv9yuSgPQQNivRWmtywM144j4BcScPs")
        }
    }
    
}
