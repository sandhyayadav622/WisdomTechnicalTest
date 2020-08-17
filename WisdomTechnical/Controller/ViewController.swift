//
//  ViewController.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import UIKit


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
      var ResDataModel: [ResponseModel]?
    @IBOutlet var listTableView: UITableView!
    var limit = "20"
    var page = "1"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSetup()
        self.getListAPI(limit: limit, page: page)
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
      if  ResDataModel?.count ?? 0 > 0{
                 listTableView.restore(true)
                 return (ResDataModel?.count)!
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
            cell.index = indexPath
        if ResDataModel?.count ?? 0 > 0{
            cell.title.text =  ResDataModel?[indexPath.row].author
             cell.descriptionLbl.text = "Description \(ResDataModel?[indexPath.row].url)"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
                    self.ResDataModel = result
                   self.tableViewSetup()
                    CustomLoader.instance.hideLoaderView()

                } else {
                   // self.showDefaultError()
                    CustomLoader.instance.hideLoaderView()
                }
            }
        }
    }
    
    
}
