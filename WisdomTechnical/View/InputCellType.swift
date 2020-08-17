//
//  InputCellType.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import Foundation
import UIKit

enum InputCellType {
    case SaveButton
    case photoData
    case none

    func getClass() -> MDBaseInputCell.Type {
        switch self {
        case .photoData: return PhotoTableCell.self
        default: return MDBaseInputCell.self
    

        }
    }
}
