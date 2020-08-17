//
//  DescriptionVC.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController {

    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var bgView: UIView!
  
    var descriptionDict: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        // Do any additional setup after loading the view.
    }
  func  initialSetup()
    {
        //bgView.backgroundColor = UIColor.white
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.cornerRadius = 20
        bgView.layer.shadowRadius = 4
        bgView.layer.shadowOffset = CGSize.zero
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.masksToBounds = false
        if descriptionDict.count > 0{
            descriptionLbl.text = "\(((descriptionDict as NSDictionary).value(forKey: "author")) as! String)"
            " \n Width of images is \((((descriptionDict as NSDictionary).value(forKey: "width")) as! Int ) ?? 0)"
           // descriptionDict.vale
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
