//
//  KeychainService.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-13.
//

import Foundation

/// Key chain service serves to save and retrieve sensitive details
final class KeychainService {
    private static let serviceName = "com.iverify.helloworld.token"
    
    /// Saves token using a unique service name
    static func saveToken(token: String?) {

        guard let token, let data = token.data(using: .utf8) else {return}
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecValueData as String: data
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { return }
    }
    /// Retrieves token as string
    static func loadToken() -> String? {
        
        guard let boolean = kCFBooleanTrue else {return nil}
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecReturnData as String: boolean,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var data: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &data)
        guard status == errSecSuccess, let tokenData = data as? Data else { return nil }

        return String(data: tokenData, encoding: .utf8)
    }

}
