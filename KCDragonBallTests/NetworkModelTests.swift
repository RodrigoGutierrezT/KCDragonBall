//
//  NetworkModelTests.swift
//  KCDragonBallTests
//
//  Created by Rodrigo on 29-09-24.
//

import XCTest
@testable import KCDragonBall

final class NetworkModelTests: XCTestCase {
    
    private var sut: NetworkModel!

    
    //MARK: - Hero Tests
    func test_getHeros_success() {
        // SetUp
        let mock = APIClientProtocolMock<[Hero]>()
        sut = NetworkModel(client: mock)
        sut.token = "mock-token"
        
        // Given
        let someResult = Result<[Hero], NetworkError>.success([])
        mock.receivedResult = someResult
        var receivedResult: Result<[Hero], NetworkError>?

        // When
        sut.getHeros { result in
            receivedResult = result
        }

        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
    
    func test_getHeros_failure() {
        // SetUp
        let mock = APIClientProtocolMock<[Hero]>()
        sut = NetworkModel(client: mock)
        sut.token = "mock-token"
        
        // Given
        let someResult = Result<[Hero], NetworkError>.failure(.unknown)
        mock.receivedResult = someResult
        var receivedResult: Result<[Hero], NetworkError>?

        // When
        sut.getHeros{ result in
            receivedResult = result
        }

        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
    
    //MARK: - Transformation Tests
    func test_getTransformations_success() {
        // SetUp
        let mock = APIClientProtocolMock<[Transformation]>()
        sut = NetworkModel(client: mock)
        sut.token = "mock-token"
        let mockHero = Hero(description: "mock-desc", name: "mock-name", favorite: true, photo: "mock-string-url", id: "mock-id")
        
        // Given
        let someResult = Result<[Transformation], NetworkError>.success([])
        mock.receivedResult = someResult
        var receivedResult: Result<[Transformation], NetworkError>?

        // When
        sut.getTransformations(for: mockHero) { result in
            receivedResult = result
        }

        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
    
    func test_getTransformations_failure() {
        // SetUp
        let mock = APIClientProtocolMock<[Transformation]>()
        sut = NetworkModel(client: mock)
        sut.token = "mock-token"
        let mockHero = Hero(description: "mock-desc", name: "mock-name", favorite: true, photo: "mock-string-url", id: "mock-id")
        
        // Given
        let someResult = Result<[Transformation], NetworkError>.failure(.unknown)
        mock.receivedResult = someResult
        var receivedResult: Result<[Transformation], NetworkError>?

        // When
        sut.getTransformations(for: mockHero){ result in
            receivedResult = result
        }

        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
    
}
