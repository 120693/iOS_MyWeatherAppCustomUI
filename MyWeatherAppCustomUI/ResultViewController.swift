//
//  ResultViewController.swift
//  MyWeatherAppCustomUI
//
//  Created by jhchoi on 2023/06/20.
//

import UIKit
import Kingfisher
import SwiftUI

class ResultViewController: UIViewController {
    
    var weatherInfo: [String:Any]?
    
    var weatherKeys: [String] = ["name","week","coord","main", "weather","wind"]
    var weatherValues: [Any] = []
    
    var mainDict: [String: Any] = [:]
    var windDict: [String: Any] = [:]
    var weatherDict: [String: Any] = [:]
    var coordDict: [String: Any] = [:]
    
    var dayName: [String] = ["월","화","수","목","금","토","일"]
    var dayIcon: [String] = ["10d","01d","02d","03d","04d","11d","13d"]
    
    let table = UITableView(frame: CGRect.zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherKeyValue()
        table.dataSource = self
                
        self.view.addSubview(table)
        
        table.snp.makeConstraints { make in
            make.edges.equalToSuperview()  // 꽉 차도록
//            make.centerX.equalToSuperview() // 수평 중앙에 맞춤
//            make.centerY.equalToSuperview() // 수직 중앙에 맞춤
//            make.width.equalToSuperview()
//            make.height.equalTo(300)
        }
        // xib 파일일 경우 사용
//        let nibName = UINib(nibName: "CardListCell", bundle: nil)
//        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
    
        table.separatorStyle = .none
        
        table.register(CoordTableViewCell.self, forCellReuseIdentifier: CoordTableViewCell.id)
        table.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.id)
        table.register(WeekTableViewCell.self, forCellReuseIdentifier: WeekTableViewCell.id)
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
    }
    
    func getWeatherKeyValue() {
        if let weatherInfo = weatherInfo {
            for (_ , value) in weatherInfo {
                weatherValues.append(value)
            }
        }
        
        if let dictionary = weatherInfo,
           let mainDictionary = dictionary["main"] as? [String: Any],
           let windDictionary = dictionary["wind"] as? [String: Any],
           let weatherArray = dictionary["weather"] as? [Any],
           let weatherDictionary = weatherArray.first as? [String: Any],
           let coordDictionary = dictionary["coord"] as? [String: Any] {
            mainDict = mainDictionary
            windDict = windDictionary
            coordDict = coordDictionary
            var weatherValues: [String: Any] = [:]
                for (key, value) in weatherDictionary {
                    weatherValues[key] = value
                }
            weatherDict = weatherValues
        }
    }
    
    // 절대온도를 섭씨로 변환
    func kToC(kelvin: Double) -> Double {
        let celsius: Double
        
        celsius = kelvin - 273.15
        
        return celsius
    }
}

extension ResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
}

extension ResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if weatherKeys[section] == "week" {
            return "7일간의 일기예보"
        } else {
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = weatherKeys[section]
        
        if sectionKey == "name" {
            return 1
        } else if sectionKey == "coord" {
            return 1
        } else if sectionKey == "main" {
            return 1
        } else if sectionKey == "weather" {
            return 1
        } else if sectionKey == "wind" {
            return 1
        } else {
            return dayIcon.count
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionKey = weatherKeys[indexPath.section]
        
        if sectionKey == "coord" {
            // 가져온 셀을 CoordTableViewCell로 다운캐스팅하여 CoordTableViewCell 객체로 사용
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoordTableViewCell.id, for: indexPath) as? CoordTableViewCell else {
                return UITableViewCell()
            }
            
            //cell.latLabel.text = "dd"
            //cell.lonLabel.text = "ss"
            
            if let lat = coordDict["lat"] as? Double {
                cell.latLabel.text = "위도 : \(lat)"
            }
            if let lon = coordDict["lon"] as? Double {
                cell.lonLabel.text = "경도 : \(lon)"
            }
            return cell
        } else if sectionKey == "name" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.id, for: indexPath) as? NameTableViewCell else {
                return UITableViewCell()
            }
            if let name = weatherInfo?["name"] as? String {
                cell.cityNameLabel.text = name
            }
            if let temp = mainDict["temp"] as? Double {
                cell.tempLabel.text = "\(String(format:"%.2f", kToC(kelvin: temp)))°C"
            } else {
                cell.tempLabel.text = nil
            }
            
            cell.descriptionLabel.text = weatherDict["description"] as? String
            
            if let minTemp = mainDict["temp_min"] as? Double {
                cell.minTempLabel.text = "최저:" + String(format:"%.2f", kToC(kelvin: minTemp)) + "°C"
            } else {
                cell.minTempLabel.text = nil
            }
            
            if let maxTemp = mainDict["temp_max"] as? Double {
                cell.maxTempLabel.text = "최고:" + String(format:"%.2f", kToC(kelvin: maxTemp)) + "°C"
            } else {
                cell.maxTempLabel.text = nil
            }
            
            if let icon = weatherDict["icon"] as? String {
                guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else { return cell }
                
                cell.iconImageView.kf.setImage(with: url)
                
                cell.iconImageView.contentMode = .scaleAspectFill
            } else {
                return cell
            }
            
            return cell
        } else if sectionKey == "week" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekTableViewCell.id, for: indexPath) as? WeekTableViewCell else {
                return UITableViewCell() }
            cell.dayName.text = dayName[indexPath.row]
            
            guard let url = URL(string: "https://openweathermap.org/img/wn/\(dayIcon[indexPath.row])@2x.png") else { return cell }
            
            cell.dayIcon.kf.setImage(with: url)
            cell.dayIcon.contentMode = .scaleAspectFill
            return cell
        } else if sectionKey == "main" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id, for: indexPath) as? MainTableViewCell else {
                return UITableViewCell()
            }
            cell.mainConfigure(with: mainDict)
            return cell
        }
        
        return UITableViewCell()
    }
}

struct PreView: PreviewProvider {
    static var previews: some View {
        ResultViewController().toPreview()
    }
}
