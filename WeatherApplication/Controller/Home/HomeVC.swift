//
//  HomeVC.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import UIKit
import Lottie

class HomeVC: UIViewController {

    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var cityListTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var animateView: AnimationView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    var lat = Double()
    var long = Double()
    
    var HomeVM = HomeViewModel()
    
    var cityMenuArray = [cityListModel]()
    lazy var searchArray = [cityListModel]()
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard.string(forKey: weatherData.cityName)
        
        //MARK: To check if user had searched for city name previously
        
        if defaults != nil {
            cityListTableView.isHidden = true
            emptyView.isHidden = false
            self.cityTF.text = defaults ?? ""
            
            let latDefaults = UserDefaults.standard.string(forKey: weatherData.latitude)
            self.lat = Double(latDefaults ?? "0.0")!
            
            let longDefaults = UserDefaults.standard.string(forKey: weatherData.longitude)
            self.long = Double(longDefaults ?? "0.0")!
            
            DispatchQueue.global(qos: .background).async {
                self.getWeather(city_name: defaults ?? "")
            }
        } else {
            cityListTableView.isHidden = false
            emptyView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()

        getCityListData()
        
    }
    
    @objc func btnLogout(){
        UserDefaults.standard.setValue(false, forKey: sessionKey.loggedInStatus)
        UserDefaults.standard.setValue(nil, forKey: weatherData.cityName)
        UserDefaults.standard.setValue(nil, forKey: weatherData.longitude)
        UserDefaults.standard.setValue(nil, forKey: weatherData.latitude)
        let vc = mainSB.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
   
    @IBAction func btnViewMore(_ sender: Any) {
        let vc = homeSB.instantiateViewController(withIdentifier: "WeatherVC") as! WeatherVC
        vc.getLat = self.lat.description
        vc.getLon = self.long.description
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func UpdateUI() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.placeLabel.text = ""
        self.weatherLabel.text = ""
        self.temperatureLabel.text = ""
        self.humidityLabel.text = ""
        
        animateView.backgroundColor = .clear
        
        //MARK: ForGradient view
        cardView.setGradientBackground(colorTop: UIColor(red:0.87, green:0.25, blue:0.30, alpha:1.0), colorBottom: UIColor(red:0.95, green:0.37, blue:0.34, alpha:0.6))
        
        cityTF.delegate = self
        cityTF.placeholder = "Please enter city name"
        cityListTableView.delegate = self
        cityListTableView.dataSource = self
        cityListTableView.tableFooterView = UIView()
        cityListTableView.register(CityTVCell.cellNib, forCellReuseIdentifier: CityTVCell.cellId) // Register nib file
        cityTF.addTarget(self, action: #selector(HomeVC.textFieldDidChange(_:)), for: .editingChanged)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(btnLogout))
    }
    
    
}
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTVCell.cellId, for: indexPath) as! CityTVCell
        cell.textLabel?.text = "\(self.searchArray[indexPath.row].name ?? ""), \(self.searchArray[indexPath.row].country ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lat = self.searchArray[indexPath.row].coord?.lat ?? 0
        self.long = self.searchArray[indexPath.row].coord?.lon ?? 0
        UserDefaults.standard.setValue(self.searchArray[indexPath.row].coord?.lat ?? 0, forKey: weatherData.latitude)
        UserDefaults.standard.setValue(self.searchArray[indexPath.row].coord?.lon ?? 0, forKey: weatherData.longitude)
        UserDefaults.standard.setValue(self.searchArray[indexPath.row].name, forKey: weatherData.cityName)
        print("Lat = \(self.lat) and lat = \(self.long)")
        
        let vc = homeSB.instantiateViewController(withIdentifier: "WeatherVC") as! WeatherVC
        vc.getLat = self.lat.description
        vc.getLon = self.long.description
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func CallLottie(jsonFile: String) {
        
        let path = Bundle.main.path(forResource: jsonFile,
                                    ofType: "json") ?? ""
        animateView.animation = Animation.filepath(path)
        animateView!.contentMode = .scaleAspectFit
        animateView!.loopMode = .loop
        animateView!.animationSpeed = 1
        animateView!.play()
    }
    
   
}
//MARK:- Api calls
extension HomeVC {
    //MARK: For calling local JSON
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
    
    func getWeather(city_name: String){
        HomeVM.getWeatherOfCity(city_name: city_name) {
            DispatchQueue.main.async {
                //MARK:  for lottie weather according to weather report
                if self.HomeVM.cityWeather?.weather?[0].main?.contains("Clear") == true{
                    self.CallLottie(jsonFile: "sunny")
                    //self.emptyView.backgroundColor = UIColor(red: 0.36, green: 0.79, blue: 1.00, alpha: 0.7)
                   
                } else if self.HomeVM.cityWeather?.weather?[0].main?.contains("Clouds") == true {
                    self.CallLottie(jsonFile: "rainy")
                    //self.emptyView.backgroundColor = UIColor(red: 0.56, green: 0.60, blue: 0.63, alpha: 0.7)
                } else if self.HomeVM.cityWeather?.weather?[0].main?.contains("Drizzle") == true {
                    self.CallLottie(jsonFile: "rainy")
                    //self.emptyView.backgroundColor = UIColor(red: 0.56, green: 0.60, blue: 0.63, alpha: 0.7)
                }
                else {
                    self.CallLottie(jsonFile: "cloudy")
                    //self.emptyView.backgroundColor = UIColor(red: 0.82, green: 0.89, blue: 0.93, alpha: 0.7)
                }
                
                self.placeLabel.text = "Place : \(self.HomeVM.cityWeather?.sys?.country ?? "") , \(self.HomeVM.cityWeather?.name ?? "")"
                self.weatherLabel.text = "Weather : \(self.HomeVM.cityWeather?.weather?[0].description ?? "")"
                self.temperatureLabel.text = "Teperature : \(self.HomeVM.cityWeather?.main?.temp ?? 0)"
                self.humidityLabel.text = "Humidity \(self.HomeVM.cityWeather?.main?.humidity ?? 0)"
            }
        }
    }
}

extension HomeVC: UITextFieldDelegate {
    
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
    
}
