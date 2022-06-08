//
//  FeedService.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import Foundation
import Alamofire

protocol FeedService {
    func getSportEvents(completion: @escaping (Result<[SVSportModel], Error>) -> Void)
}

extension RequestRouter {
    enum Feed {
        case getSportEvents
    }
}

extension RequestRouter.Feed: RequestProtocol {
    var path: String {
        switch self {
        case .getSportEvents:
            return "/sports"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getSportEvents:
            return .get
        }
    }


}
