//
//  MoviesListModel.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

struct ResponseModel {
    let id: String?
    let author: String?
    let width:Int?
    let height: Int?
    let url: String?
    let download_url: String?
}
extension ResponseModel: Decodable {
    private enum ResponseCodingKeys: String, CodingKey {
        case id
        case author
        case width
       case height
        case url
        case download_url
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
       
        id = try container.decodeIfPresent(String.self, forKey: .id)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        width = try container.decodeIfPresent(Int.self, forKey: .width)
         height = try container.decodeIfPresent(Int.self, forKey: .height)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        download_url = try container.decodeIfPresent(String.self, forKey: .download_url)
    }
   
}
