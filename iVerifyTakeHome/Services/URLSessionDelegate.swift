//
//  URLSessionDelegate.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-17.
//

import Foundation
/// Implements certificate pinning
class NetworkManagerURLSessionDelegate: NSObject, URLSessionDelegate {
    
    // Pinned certificate's common name
    let pinnedCertificateCommonName = "hiring.iverify.io"
    
    /// Delegate function used to compare certificates
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if let serverTrust = challenge.protectionSpace.serverTrust,
           let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
            
            // Get the server's common name from the certificate
            if let serverCommonName = getCommonName(from: serverCertificate) {
                
                // Compare with the pinned certificate's common name
                if serverCommonName == pinnedCertificateCommonName {
                    let credential = URLCredential(trust: serverTrust)
                    completionHandler(.useCredential, credential)
                    return
                }
            }
        }
        
        // If the certificate doesn't match, reject the connection
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
    /// Retreives common name from certificate
    private func getCommonName(from certificate: SecCertificate) -> String? {
        if let commonName = SecCertificateCopySubjectSummary(certificate) {
            return commonName as String
        }
        return nil
    }
}
