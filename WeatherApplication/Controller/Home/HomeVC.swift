//
//  HomeVC.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import UIKit
import Lottie

class HomeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var cityListTableView: UITableView!
    @IBOutlet weak var emptyView: AnimationView!
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var lat = Double()
    var long = Double()
    
    var HomeVM = HomeViewModel()
    
    var cityMenuArray = [cityListModel]()
    lazy var searchArray = [cityListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTF.delegate = self
        cityTF.placeholder = "Please enter city name"
        cityListTableView.delegate = self
        cityListTableView.dataSource = self
        cityListTableView.register(CityTVCell.cellNib, forCellReuseIdentifier: CityTVCell.cellId)
        cityTF.addTarget(self, action: #selector(HomeVC.textFieldDidChange(_:)), for: .editingChanged)

        getCityListData()
        
        let defaults = UserDefaults.standard.string(forKey: "City_Name")
        
        if defaults != nil {
            cityListTableView.isHidden = true
            emptyView.isHidden = false
            self.cityTF.text = defaults ?? ""
            self.getWeather(city_name: defaults ?? "")
        } else {
            cityListTableView.isHidden = false
            emptyView.isHidden = true
        }
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let searchText = cityTF.text!
        self.cityListTableView.isHidden = false
        self.emptyView.isHidden = true
        
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lat = self.searchArray[indexPath.row].coord?.lat ?? 0
        self.long = self.searchArray[indexPath.row].coord?.lon ?? 0
        UserDefaults.standard.setValue(self.searchArray[indexPath.row].name, forKey: "City_Name")
        print("Lat = \(self.lat) and lat = \(self.long)")
        
        let vc = homeSB.instantiateViewController(withIdentifier: "WeatherVC") as! WeatherVC
        vc.getLat = self.lat.description
        vc.getLon = self.long.description
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func CallLottie(jsonFile: String) {
        let path = Bundle.main.path(forResource: jsonFile,
                                    ofType: "json") ?? ""
        emptyView.animation = Animation.filepath(path)
        emptyView!.contentMode = .scaleAspectFit
        emptyView!.loopMode = .loop
        emptyView!.animationSpeed = 0.5
        emptyView!.play()
    }
    
    func getWeather(city_name: String){
        HomeVM.getWeatherOfCity(city_name: city_name) {
            DispatchQueue.main.async {
                
                //UserDefaults.standard.setValue(city_name, forKey: "City_Name")
                
//                //MARK: To display error message
//                if self.HomeVM.errorMessage != "" {
//                    self.emptyView.isHidden = false
////                    self.weatherView.isHidden = true
//                    self.emptyView.backgroundColor = .white
////                    self.errorLabel.text = self.HomeVM.errorMessage
//                } else {
//                    self.emptyView.isHidden = true
////                    self.weatherView.isHidden = false
//                }
                
                //MARK:  for lottie weather according to weather report
                if self.HomeVM.cityWeather?.weather?[0].main?.contains("Clear") == true{
                    self.CallLottie(jsonFile: "sunny")
                   // self.weatherView.backgroundColor = UIColor(red: 0.36, green: 0.79, blue: 1.00, alpha: 1.00)
                   
                } else if self.HomeVM.cityWeather?.weather?[0].main?.contains("Clouds") == true {
                    self.CallLottie(jsonFile: "rainy")
                    //self.weatherView.backgroundColor = UIColor(red: 0.56, green: 0.60, blue: 0.63, alpha: 1.00)
                } else {
                    self.CallLottie(jsonFile: "cloudy")
                    //self.weatherView.backgroundColor = UIColor(red: 0.82, green: 0.89, blue: 0.93, alpha: 1.00)
                }
                
                self.placeLabel.text = "Place : \(self.HomeVM.cityWeather?.sys?.country ?? "") , \(self.HomeVM.cityWeather?.name ?? "")"
                self.weatherLabel.text = "Weather : \(self.HomeVM.cityWeather?.weather?[0].description ?? "")"
                self.temperatureLabel.text = "Teperature : \(self.HomeVM.cityWeather?.main?.temp ?? 0)"
                self.humidityLabel.text = "Humidity \(self.HomeVM.cityWeather?.main?.humidity ?? 0)"
            }
        }
    }
}
