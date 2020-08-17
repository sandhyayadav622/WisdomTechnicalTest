
//
//  CMSEndPoint.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import Foundation

enum CMSEndpoint {
    case user
    var url: String {
        switch self {
        case .user:
            return CMSEndpoint.getENVEndPoint()
        }
    }

    static func getENVEndPoint() -> String {
        var url = "https://api.themoviedb.org/3/movie/"
//        #if DEVELOPMENT
//         url = "https://api.themoviedb.org/3/movie/"
//     
//        #endif
        return url
    }
}
