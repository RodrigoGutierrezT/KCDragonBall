//
//  APIClientProtocolMock.swift
//  KCDragonBallTests
//
//  Created by Rodrigo on 29-09-24.
//

import Foundation
@testable import KCDragonBall

// Necesitamos definir un generico con la misma restriccion que T
// Para poder enviar valores al completion handler
final class APIClientProtocolMock<C: Codable>: APIClientProtocol {
    var session: URLSession = .shared
    
    var didCallRequest = false
    var receivedRequest: URLRequest?
    // Este generico C tiene la misma restriccion `Codable` que T
    var receivedResult: Result<C, NetworkError>?
    func request<T: Codable>(
        _ request: URLRequest,
        using: T.Type,
        completion: @escaping (Result<T, KCDragonBall.NetworkError>) -> Void
    ) {
        receivedRequest = request
        didCallRequest = true
        
        if let result = receivedResult as? Result<T, NetworkError> {
            completion(result)
        }
    }
    
    func authenticate(_ request: URLRequest, completion: @escaping (Result<String, KCDragonBall.NetworkError>) -> Void) {
        // no es necesario implementar, no se está probando
    }

}
