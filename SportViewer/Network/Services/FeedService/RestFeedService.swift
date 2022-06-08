//
//  RestFeedService.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import Foundation

struct RestFeedService: FeedService, BaseNetworkService {

    var networkManager: SessionProtocol

    func getSportEvents(completion: @escaping (Result<[SVSportModel], Error>) -> Void) {
        guard let request = networkManager.request(RequestRouter.Feed.getSportEvents) else { completion(.failure(URLError(.badURL))); return }

        request.responseData { response in
            switch response.result {
            case .success(let data):
                guard let objects: [SVSportModel] = networkManager.objectfromData(data) else { completion(.failure(URLError(.badServerResponse))); return }
                completion(.success(objects))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
