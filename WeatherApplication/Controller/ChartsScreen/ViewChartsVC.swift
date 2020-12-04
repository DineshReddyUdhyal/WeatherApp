//
//  ViewChartsVC.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import UIKit
import Charts

class ViewChartsVC: UIViewController {

    @IBOutlet weak var barChart: LineChartView!
    
    var numbers = [WeatherListModelHourly]()
    var dataEntries: [ChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.noDataText = "No weather list"
        
        for i in 0..<numbers.count {
            let values = ChartDataEntry(x: Double(i), y: numbers[i].temp ?? 0.0)
            self.dataEntries.append(values)
        }
        
        let line1 = LineChartDataSet(entries: dataEntries, label: "Weather App")
        line1.colors = [NSUIColor.black]
        
//        line1.circleColors = [NSUIColor.blue]
//        line1.fillColor = .black
//        line1.highlightColor = .yellow
        
        let data = LineChartData()
        data.addDataSet(line1)
        barChart.data = data
        barChart.chartDescription?.text = "Weather App"
    }
    
}
