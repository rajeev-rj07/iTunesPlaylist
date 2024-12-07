//
//  NetworkManager.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 07/12/24.
//

import Foundation
import Combine

final class NetworkManager {

    static let shared = NetworkManager()
    private(set) var cancellables = Set<AnyCancellable>()

    func fetchSongs(searchTerm: String, page: Int, limit: Int) -> Future<SongResult,APIError> {
        let url = createURL(for: searchTerm, type: .song, page: page, limit: limit)
        return fetch(type: SongResult.self, url: url)
    }

    func fetch<T: Decodable>(type: T.Type, url: URL?) -> Future<T,APIError> {

        return Future { promise in
            guard let URL = url else {
                return promise(.failure(.badURL))
            }

            URLSession.shared.dataTaskPublisher(for: URL)
                .logEvents()
                .tryMap { (data, response) -> Data in
                    if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                        throw APIError.badResponse(response.statusCode)
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingerror as DecodingError:
                            switch decodingerror {
                            case .typeMismatch(let type, let context):
                                print("Type '\(type)' mismatch:", context.debugDescription)
                                print("codingPath:", context.codingPath)
                                promise(.failure(.decoding(decodingerror)))
                            case .valueNotFound(let value, let context):
                                print("Value '\(value)' not found:", context.debugDescription)
                                print("codingPath:", context.codingPath)
                                promise(.failure(.decoding(decodingerror)))
                            case .keyNotFound(let key, let context):
                                print("Key '\(key)' not found:", context.debugDescription)
                                print("codingPath:", context.codingPath)
                                promise(.failure(.decoding(decodingerror)))
                            case .dataCorrupted(let context):
                                print(context)
                                promise(.failure(.decoding(decodingerror)))
                            default:
                                promise(.failure(.decoding(decodingerror)))
                            }
                        case let unrecognizedError as APIError:
                            promise(.failure(unrecognizedError))
                        default:
                            promise(.failure(.unknown))
                        }
                    }
                } receiveValue: { promise(.success($0)) }
                .store(in: &NetworkManager.shared.cancellables)
        }
    }

    func createURL(for searchTerm: String, type: EntityType, page: Int?, limit: Int?) -> URL? {
        // https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5&offset=10
        let baseURL = "https://itunes.apple.com/search"
        var queryItems = [URLQueryItem(name: "term", value: searchTerm),
                          URLQueryItem(name: "entity", value: type.rawValue)]

        if let page = page, let limit = limit {
            let offset = page * limit
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        }

        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
}

/// To log the events with ease we can use .logOneEvent() publisher on URLSession.DataTaskPublisher
fileprivate func logOneEvent(data: Data, response: URLResponse) {
    print("Got \(data.count) bytes")
    print("Response: \(response)")
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func logEvents() -> Publishers.HandleEvents<Self> {
        return self.handleEvents(receiveOutput: logOneEvent)
    }
}
