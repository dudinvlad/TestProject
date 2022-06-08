//
//  Session.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import Foundation
import Alamofire

class SVSession: SessionProtocol {
    // MARK: - Variables

    var sessionManager: Session
    var encoder: JSONEncoder = .init()
    var decoder: JSONDecoder = .init()

    private var baseURL: URL?
    private let configuration: URLSessionConfiguration

    // MARK: - Lifecycle

    init(baseURL: String) {
        self.baseURL = URL(string: baseURL)

        self.configuration = URLSessionConfiguration.af.default
        self.configuration.timeoutIntervalForRequest = 30
        self.configuration.waitsForConnectivity = true
        self.configuration.requestCachePolicy = .reloadRevalidatingCacheData

        self.sessionManager = .init(
            configuration: configuration,
            cachedResponseHandler: ResponseCacher(behavior: .cache)
        )
        self.initialSetup()
    }

    // MARK: - Public

    func request(_ type: RequestProtocol) -> DataRequest? {
        guard let baseURL = self.baseURL else { return nil }

        return sessionManager.request(
            baseURL.appendingPathComponent(type.path),
            method: type.method
        )
    }

    func objectfromData<T>(_ data: Data) -> T? where T : Decodable {
        do {
            let object = try self.decoder.decode(T.self, from: data)
            return object
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }

    // MARK: - Private

    private func initialSetup() {
        configurateDecoder()
        configurateEncoder()
    }

    private func configurateDecoder() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
    }

    private func configurateEncoder() {
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
    }

}
