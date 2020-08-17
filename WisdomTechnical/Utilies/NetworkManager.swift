//
//  NetworkManager.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

struct NetworkManager<T: EndPointType, S: Decodable> {
    func getAPIResponse(loginEndPoint: APIEndPoint, completion: @escaping (_ loginResModel: S?, _ response: HTTPURLResponse?, _ error: String?) -> Void) {
        API.request(loginEndPoint) { data, response, error in
            print(loginEndPoint)
            let response = response as? HTTPURLResponse
            var model: S?
            if error != nil {
                completion(model, response, "Please check your network connection.")
            }

            if let response = response {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(model, response, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        model = try JSONDecoder().decode(S.self, from: responseData)
                        completion(model, response, nil)
                    } catch {
                        print(error)
                        completion(nil, response, NetworkResponse.unableToDecode.rawValue)
                    }
                case let .failure(networkFailureError):
                    completion(nil, response, networkFailureError)
                }
            }
        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200 ... 299: return .success
        case 401 ... 500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501 ... 599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
