//
//  WeatherVC.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import UIKit

class WeatherVC: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    
    var getLat = String()
    var getLon = String()
    
    var weatherListVM =  WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.register(WeatherTVCell.cellNib, forCellReuseIdentifier: WeatherTVCell.cellId)
        weatherTableView.tableFooterView = UIView()
        getWeatherList()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Weather Graph", style: .plain, target: self, action: #selector(btnViewCharts))
        
        
    }
    
    @objc func btnViewCharts(){
        let vc = homeSB.instantiateViewController(withIdentifier: "ViewChartsVC") as! ViewChartsVC
        vc.numbers = (self.weatherListVM.cityWeatherList?.hourly)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListVM.cityWeatherList?.hourly?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTVCell.cellId, for: indexPath) as! WeatherTVCell
        cell.itemData = weatherListVM.cityWeatherList?.hourly?[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
}
extension WeatherVC {
    func getWeatherList(){
        weatherListVM.getWeatherOfCity(lat: getLat, lon: getLon) {
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
        }
    }
}
