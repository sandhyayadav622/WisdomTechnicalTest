//
//  LoginEndPoint.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import Foundation

struct ParamKeys {
    static let api_key = "api_key"
    static let language = "language"
    static let page = "page"

}

public enum APIEndPoint: EndPointType {
    case moviesListAPI(apiKey: String, language: String, page: Int)
    case movieDetailsApi(movieID: Int, apiKey: String, language: String)

}

extension APIEndPoint {
     var headers: HTTPHeaders? {
         switch self {
          default:
              return nil
         }
    }
  
    var environmentBaseURL: String {
        return CMSEndpoint.user.url
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }

    var path: String {
        switch self {
        case .moviesListAPI:
            return "popular"
         case let .movieDetailsApi(movieID,_,_):
         return  "\(movieID)"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .moviesListAPI(_, _, _), .movieDetailsApi(_, _, _):
        return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case let .moviesListAPI(api_key, language, page):
        return .requestWithParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: [ParamKeys.api_key: api_key, ParamKeys.language: language , ParamKeys.page: page])
        case let .movieDetailsApi(_, api_key, language):
          return .requestWithParameters(bodyParameters: nil , bodyEncoding: .urlEncoding, urlParameters: [ParamKeys.api_key: api_key, ParamKeys.language: language])

        }
    }
}
