//
//  PhotoTableCell.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import UIKit

class PhotoTableCell: MDBaseInputCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var bgView: UIView!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var img: UIImageView!
    
    var index: IndexPath!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = UIColor.white
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.cornerRadius = 20
        bgView.layer.shadowRadius = 4
        bgView.layer.shadowOffset = CGSize.zero
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
