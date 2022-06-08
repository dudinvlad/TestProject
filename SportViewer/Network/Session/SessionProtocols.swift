//
//  SessionProtocols.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import Alamofire
import Foundation

protocol SessionProtocol: AnyObject {
    var sessionManager: Session { get }
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }

    func request(_ type: RequestProtocol) -> DataRequest?
    func objectfromData<T: Decodable>(_ data: Data) -> T?
}
