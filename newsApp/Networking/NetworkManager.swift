//
//  NetworkManager.swift
//  newsApp
//
//  Created by Alperen Kişi on 01/06/2021.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request(with url: String,onComplete: @escaping (Welcome) -> (),onError: @escaping () -> ()) {
        AF.request(url, method: .get, encoding: URLEncoding.default).response { (response) in
            guard let remoteData = response.data else { return onError() }
            do {
                let decodedData = try JSONDecoder().decode(Welcome.self, from: remoteData)
                onComplete(decodedData)
            }
            catch {
                onError()
            }
        }
    }
}
