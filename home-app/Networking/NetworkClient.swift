//
//  NetworkClient.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import Combine
import Foundation

protocol NetworkClient {
    func request<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, NetworkError> where T: Decodable
}

final class NetworkClientImpl: NetworkClient {
    
    func request<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, NetworkError> where T: Decodable {
        
        guard let url = components.url else {
            let error = NetworkError.unknown(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .tryMap(handleResponse)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { NetworkError.unknown(description: $0.localizedDescription) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func handleResponse(data: Data, response: URLResponse) throws -> Data {
        if let response = response as? HTTPURLResponse,
           !(200...299).contains(response.statusCode) {
            throw NetworkError.httpError(statusCode: response.statusCode)
        }
        return data
    }
}

enum NetworkError: Error, LocalizedError {
    case httpError(statusCode: Int)
    case unknown(description: String)
}
