//
//  NetworkModel.swift
//  KCDragonBall
//
//  Created by Rodrigo on 24-09-24.
//

import Foundation

final class NetworkModel {
    static let shared = NetworkModel()
    
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private var token: String?
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func login (
        user: String,
        password: String,
        completition: @escaping (Result<String, NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/auth/login"
        
        guard let url = components.url else {
            completition(.failure(.malformedURL))
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        
        guard let loginData = loginString.data(using: .utf8) else {
            completition(.failure(.encodingFailed))
            return
        }
        
        let base64LogingString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LogingString)", forHTTPHeaderField: "Authorization")
        
        client.authenticate(request) { [weak self] result in
            switch result {
            case let .success(token):
                self?.token = token
            case .failure:
                break
            }
            completition(result)
        }
    }
    
    func getHeroes (
        completition: @escaping (Result<[Hero], NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else {
            completition(.failure(.malformedURL))
            return
        }
        
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["name": ""]) else {
            completition(.failure(.serializationFailed))
            return
        }
        
        guard let token else {
            completition(.failure(.notAuthorized))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = serializedBody
        
        client.request(request, using: [Hero].self, completition: completition)
        
    }
    
    func getTransformations (
        for hero: Hero,
        completition: @escaping (Result<[Transformation], NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        
        guard let url = components.url else {
            completition(.failure(.malformedURL))
            return
        }
        
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["id": hero.id]) else {
            completition(.failure(.serializationFailed))
            return
        }
        
        guard let token else {
            completition(.failure(.notAuthorized))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = serializedBody
        
        client.request(request, using: [Transformation].self, completition: completition)
    }
    
}
