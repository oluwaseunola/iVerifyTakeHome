//
//  NetworkManager.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-13.
//

import Foundation
/// Errors for different networking cases
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case noToken
    case parsingError
}

/// Networking protocol for testability later on
protocol Networking {
    func fetchData(page: Int, completion: @escaping (Result<[Device], Error>) -> Void)
}

/// Network manager for fetching device data
class NetworkManager: Networking {
    
    let baseURL: String
    let session: URLSession

    init(baseURL: String, session: URLSession = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    
    /// Fetches device data from endpoint
    /// - Parameters:
    ///   - page: page number for pagination
    ///   - completion: completion handler returns a list of device objects or an error in a failure case
    func fetchData(page: Int = 1, completion: @escaping (Result<[Device], Error>) -> Void) {
        
        // Ensures we have a token in order to make an API call
        guard let token = KeychainService.loadToken() else{
            completion(.failure(APIError.noToken))
            return
        }
        
        // Ensure URL is valid
        guard let url = URL(string: baseURL) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // Set URL query components
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "pages", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "\(30)")
        ]
        
        
        guard let paginatedURL = components?.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // Create request
        var request = URLRequest(url: paginatedURL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                           completion(.failure(error))
                           return
                       }

                       guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                           completion(.failure(APIError.invalidResponse))
                           return
                       }

                       guard let data = data else {
                           completion(.failure(APIError.noData))
                           return
                       }
            
            do{
                let deviceList = try JSONDecoder().decode(DeviceList.self, from: data)
                completion(.success(deviceList.devices))
            }catch{
                completion(.failure(APIError.parsingError))
            }
        }

        task.resume()
    }
    
}

