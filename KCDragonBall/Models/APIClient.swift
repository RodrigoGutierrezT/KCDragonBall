//
//  APIClient.swift
//  KCDragonBall
//
//  Created by Rodrigo on 24-09-24.
//

import Foundation

enum NetworkError: Error, Equatable {
    case malformedURL
    case noData
    case statusCode(code: Int?)
    case decodingFailed
    case encodingFailed
    case serializationFailed
    case notAuthorized
    case unknown
}

protocol APIClientProtocol {
    
    func authenticate(
        _ request: URLRequest,
        completition: @escaping (Result<String, NetworkError>) -> Void
    )
    
    func request<T: Decodable>(
        _ request: URLRequest,
        using: T.Type,
        completition: @escaping (Result<T, NetworkError>) -> Void
    )
}

struct APIClient: APIClientProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func authenticate(
        _ request: URLRequest,
        completition: @escaping (Result<String, NetworkError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            let result: Result<String, NetworkError>
            
            defer {
                completition(result)
            }
            
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            
            guard let data else {
                result = .failure(.noData)
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                result = .failure(.decodingFailed)
                return
            }
            
            result = .success(token)
        }
        
        task.resume()
    }
    
    func request<T: Decodable>(
        _ request: URLRequest,
        using: T.Type,
        completition: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            let result: Result<T, NetworkError>
            
            defer {
                completition(result)
            }
            
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            
            guard let data else {
                result = .failure(.noData)
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(using, from: data) else {
                result = .failure(.decodingFailed)
                return
            }
            
            result = .success(decodedResponse)
        }
        
        task.resume()
    }
}
