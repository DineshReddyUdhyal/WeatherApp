//
//  HomeVC.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import UIKit

class HomeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var cityListTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var lat = Double()
    var long = Double()
    
    var cityMenuArray = [cityListModel]()
    lazy var searchArray = [cityListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityListTableView.delegate = self
        cityListTableView.dataSource = self
        cityListTableView.register(CityTVCell.cellNib, forCellReuseIdentifier: CityTVCell.cellId)
        cityTF.addTarget(self, action: #selector(HomeVC.textFieldDidChange(_:)), for: .editingChanged)

        getCityListData()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        let searchText = cityTF.text!
        searchArray = searchText.isEmpty ? self.cityMenuArray : self.cityMenuArray.filter{($0.name?.capitalized.contains(searchText.capitalized))!}
        cityListTableView.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func getCityListData() {
        ProgressHud.showActivityIndicator(uiView: self.view)
//        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                CityManager.sharedInstance.getCityListResponse(onSuccess: {json in
                    let array = json as? [JSON]
                    for dictionary in array! {
                        guard let City_Items = cityListModel(json: dictionary) else { continue }
                        self.cityMenuArray.append(City_Items)
                    }
                    ProgressHud.hideActivityIndicator(uiView: self.view)
                })
                
            }
//        }
    }
}
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTVCell.cellId, for: indexPath) as! CityTVCell
        cell.textLabel?.text = "\(self.searchArray[indexPath.row].name ?? ""), \(self.searchArray[indexPath.row].state ?? "" ), \(self.searchArray[indexPath.row].country ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lat = self.searchArray[indexPath.row].coord?.lat ?? 0
        self.long = self.searchArray[indexPath.row].coord?.lon ?? 0
        
        print("Lat = \(self.lat) and lat = \(self.long)")
        
    }
    
}
