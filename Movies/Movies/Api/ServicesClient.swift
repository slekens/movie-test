//
//  Services.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//
import Foundation
import Combine
/// Is Our Api client.
struct ServicesClient {
    /// Generic response for all api calls.
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    /// Gerneric Function to api calls.
    /// - Parameter request: The api request.
    /// - Returns: The pub with the generic data object, and error if we found some.
    func fetch<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
