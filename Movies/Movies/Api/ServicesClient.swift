//
//  Services.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//
import Foundation
import Combine
/// This is Our Api client.
struct ServicesClient {
    private static let servicesQueue = DispatchQueue(label: "services-queue")
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
            .dataTaskPublisher(for: request, cachedResponseOnError: true)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .subscribe(on: Self.servicesQueue)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
// Type alias for the publisher output.
typealias ShortOutput = URLSession.DataTaskPublisher.Output
// MARK: - Extension to manage simple cache data.
extension URLSession {
    func dataTaskPublisher(for request: URLRequest, cachedResponseOnError: Bool) -> AnyPublisher<ShortOutput, Error> {
        return self.dataTaskPublisher(for: request)
            .tryCatch { [weak self] (error) -> AnyPublisher<ShortOutput, Never> in
                guard cachedResponseOnError,
                    let urlCache = self?.configuration.urlCache,
                    let cachedResponse = urlCache.cachedResponse(for: request)
                else {
                    throw error
                }
                return Just(ShortOutput(
                    data: cachedResponse.data,
                    response: cachedResponse.response
                )).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
