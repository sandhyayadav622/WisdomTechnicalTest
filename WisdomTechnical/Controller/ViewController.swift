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
      var ResDataModel: ResponseModel?
    @IBOutlet var moviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPopularMoviesListAPI()
    }


}

// MARK: - Private functions

extension ViewController {
    private func tableViewSetup() {
        cellTypes = [.photoCell]
        for type in cellTypes {
            moviesTableView.registerNibForCellClass(type.cellType().getClass())
        }
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.reloadData()
    }
}

// MARK: UITableViewDataSource & delegets

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }

     func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableCell.cellReuseIdentifier(), for: indexPath) as! PhotoTableCell
        // API data
        cell.index = indexPath
            cell.title.text = "Title:"
             cell.descriptionLbl.text = "Description"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARKS: API call

extension ViewController {
    func getPopularMoviesListAPI() {
        CustomLoader.instance.showLoaderView()
        let networkManager =  NetworkManager<APIEndPoint, ResponseModel >()
       
        networkManager.getAPIResponse(loginEndPoint: .moviesListAPI(apiKey: apiKey, language: language, page: page) ) { result, response, _ in
            DispatchQueue.main.async {
                CustomLoader.instance.hideLoaderView()
                if response?.statusCode == 200 {
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