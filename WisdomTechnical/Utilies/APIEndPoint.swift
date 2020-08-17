//
//  LoginEndPoint.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import Foundation

struct ParamKeys {
   
    static let limit = "limit"
    static let page = "page"

}

public enum APIEndPoint: EndPointType {
    case ListAPI(limit: String, page: String)
  

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
            case  .ListAPI :
            return "list"
        
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .ListAPI(_, _):
        return .get
        }
    }

    var task: HTTPTask {
        switch self {

        case let .ListAPI(limit, page):
            return .requestWithParameters(bodyParameters: nil , bodyEncoding: .urlEncoding, urlParameters: [ParamKeys.limit: limit, ParamKeys.page: page])

        }
    }
}
