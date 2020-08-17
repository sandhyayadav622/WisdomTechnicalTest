//
//  MDBaseInputCell.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import Foundation
import UIKit


class MDBaseInputCell: UITableViewCell {
    // MARK: Internal Properties

    var type: InputCellType!
    var getTappedTextField: ((UITextField) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func displayProfileImage(image: UIImage) {
        setProfileImage(img: image)
    }


 func setProfileImage(img _: UIImage) {}
   
}
