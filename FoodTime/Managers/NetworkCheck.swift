//
//  NetworkCheck.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 26.09.23.
//

import Foundation
import Combine

struct TestModel: Codable {
    let name: String
}

class NetworkCheck {
    
    var cancellable: AnyCancellable?

    let networkManager = NetworkManager()
    let url = URL(string: "https://stg.jommakan.asia/api/web/v1/clients/checkoccasion")!
    init() {
        networkManager.apiRequest(method: .GET, url: url) { result in
            switch result {
            case let .success(data):
                print(data as Any)
            case let .failure(error):
                print(error)
            }
        }
    }
}
