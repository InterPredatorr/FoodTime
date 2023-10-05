//
//  NetworkManager.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 26.09.23.
//

import Foundation
import Combine

enum APIError: Error {
    case networkError(Error)
    case apiError(String)
    case timeoutError
    case corruptedDataError
}

enum HTTPMethod: String {
    case GET
    case POST
}

struct ResponseType<T: Decodable>: Decodable {
    let success: Bool
    let message: String
    let data: T
}

class NetworkManager {
    
    typealias JSON = [String: Any]
    
    func apiRequest(method: HTTPMethod, url: URL,
                    parameters: JSON? = nil,
                    headers: [String: String]? = nil,
                    completion: @escaping (Result<Any?, APIError>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        setHeaders(in: &request, headers: headers)
        
        let parametersResult = serializeParameters(parameters)
        
        switch setRequestParameters(&request, parametersResult) {
        case .success:
            break
        case let .failure(error):
            completion(.failure(error))
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  !(400...599 ~= response.statusCode),
                  error == nil else {
                if (error as? URLError)?.code == .timedOut {
                    completion(.failure(.timeoutError))
                }
                completion(.failure(.networkError(error!))) //will be handled
                return
            }
            do {
                let data = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                if (data["success"] as! Int) == 1 {
                    completion(.success(data["data"]))
                } else {
                    //will be handled
                }
                
            } catch {
                completion(.failure(.corruptedDataError))
            }
            
        }
        .resume()
    }
    
    
    private func setHeaders(in request: inout URLRequest, headers: [String: String]?) {
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
    
    private func serializeParameters(_ parameters: JSON?) -> Result<Data, APIError> {
        guard let parameters = parameters else {
            return .success(Data())
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            return .success(jsonData)
        } catch {
            return .failure(.apiError("Invalid parameter format"))
        }
    }
    
    private func setRequestParameters(_ request: inout URLRequest, _ parameterResult: Result<Data, APIError>) -> Result<Void, APIError> {
        switch parameterResult {
        case .success(let jsonData):
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
