//
//  NetworkManager.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import Foundation

enum ApiURL: String {
    case baseUrl = "https://618d3aa7fe09aa001744060a.mockapi.io/api"
}

final class NetworkManager: SVSession {
    struct BaseResponse<T: Decodable>: Decodable {
        let data: T
    }
}

protocol BaseNetworkService {
    var networkManager: SessionProtocol { get }
}
