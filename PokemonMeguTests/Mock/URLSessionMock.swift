//
//  URLSessionMock.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import Foundation
import Testing
@testable import PokemonMegu

// MARK: - URLProtocol Stub

final class URLSessionMock: URLProtocol {
    static var responseData: Data?
    static var response: URLResponse?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let error = URLSessionMock.error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            if let response = URLSessionMock.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = URLSessionMock.responseData {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {}

    static func reset() {
        responseData = nil
        response = nil
        error = nil
    }
    
    static func stubResponse(for urlString: String?, statusCode: Int = 200, data: Data?) {
        guard let urlString,
              let url = URL(string: urlString) else { return }

        let response = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )

        URLSessionMock.response = response
        URLSessionMock.responseData = data
        URLSessionMock.error = nil
    }
}

private func makeMockSession() -> URLSession {
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [URLSessionMock.self]
    return URLSession(configuration: config)
}
