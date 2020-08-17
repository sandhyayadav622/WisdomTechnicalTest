//
//  ViewController.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import UIKit
import SDWebImage

enum FormCellType {
case photoCell
case Submit
    
  func cellType() -> InputCellType {
           switch self {
           case .Submit: return .SaveButton
           case .photoCell: return .photoData
           }
       }
}

class ViewController: UIViewController {

  var cellTypes = [FormCellType]()
    
    var ResDataModel = [ResponseModel]()
    var currentDataSource: [ResponseModel] = []
    @IBOutlet var listTableView: UITableView!
    var limit = "20"
    var page = 1
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSetup()
        self.getListAPI(limit: limit, page: "\(page)")
    }


}

// MARK: - Private functions

extension ViewController {
    private func tableViewSetup() {
        cellTypes = [.photoCell]
        for type in cellTypes {
            listTableView.registerNibForCellClass(type.cellType().getClass())
        }
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.reloadData()
    }
}

// MARK: UITableViewDataSource & delegets

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if  currentDataSource.count > 0{
                 listTableView.restore(true)
            return (currentDataSource.count)
             } else {
                 listTableView.setEmptyMessage(" No Record(s) Please try again.")
                 return 0
             }
         }

     func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableCell.cellReuseIdentifier(), for: indexPath) as! PhotoTableCell
        // API data
        index = indexPath.row
        if currentDataSource.count > 0{
            cell.title.text =  currentDataSource[indexPath.row].author
            cell.descriptionLbl.text = "Description \(currentDataSource[indexPath.row].url ?? "")"
            if currentDataSource[indexPath.row].download_url != ""
            {
                cell.img.sd_setImage(with: URL(string: (currentDataSource[indexPath.row].download_url)!), placeholderImage: UIImage(systemName:"logo"))
            }
            cell.imgHeightConstrant.constant = getHeight(widthOriginal: UIScreen.main.bounds.size.width, height: (currentDataSource[indexPath.row].height)!, width: (currentDataSource[indexPath.row].width)!)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DescriptionVC") as! DescriptionVC
        var selectedImageData = [String: Any]()
        selectedImageData["width"] =  currentDataSource[indexPath.row].width
        selectedImageData["height"] =  currentDataSource[indexPath.row].height
        selectedImageData["author"] =  currentDataSource[indexPath.row].author
        vc.descriptionDict =  selectedImageData
        self.present(vc,animated:true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //Bottom Refresh
        if scrollView == listTableView{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if index + 1 == currentDataSource.count{
                self.getListAPI(limit: limit, page: "\(page + 1)")
                }
            }
        }
    }
    func getHeight(widthOriginal: CGFloat, height: Int ,width: Int) -> CGFloat{
        return widthOriginal * CGFloat(height) / CGFloat(width)
        }
}

// MARKS: API call

extension ViewController {
    func getListAPI(limit: String,page : String) {
        CustomLoader.instance.showLoaderView()
        let networkManager =  NetworkManager<APIEndPoint, [ResponseModel] >()
       
        networkManager.getAPIResponse(loginEndPoint: .ListAPI(limit: limit, page: page) ) { result, response, _ in
            DispatchQueue.main.async {
                CustomLoader.instance.hideLoaderView()
                if response?.statusCode == 200 {
                    self.ResDataModel = result!
                    CustomLoader.instance.hideLoaderView()
                    self.currentDataSource.append(contentsOf: self.ResDataModel)
                    self.tableViewSetup()
                } else {
                    CustomLoader.instance.hideLoaderView()
                }
            }
        }
    }
    
    
}
