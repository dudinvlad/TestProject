//
//  RequestProtocol.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import Foundation
import Alamofire

enum RequestRouter {}

protocol RequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var paramEncoding: ParameterEncoding { get }
}

extension RequestProtocol {
    var paramEncoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
