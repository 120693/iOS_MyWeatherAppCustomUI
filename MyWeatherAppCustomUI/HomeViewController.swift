//
//  HomeViewController.swift
//  MyWeatherAppCustomUI
//
//  Created by jhchoi on 2023/06/15.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let cityNameTextField = UITextField()
    
    let resultViewController = ResultViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.title = "실시간 날씨 정보"
        
        // 네비게이션 설정
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "homekit"), style: .plain, target: nil, action: nil)
    
        // CGRect 사용
//        let firstLabel = UILabel(frame: CGRect(x: 100, y: 200, width: 230, height: 21))
//        firstLabel.text = "지명을 입력하세요."
//        firstLabel.font = UIFont.systemFont(ofSize: 20)
//
//        self.view.addSubview(firstLabel)
//
//        let cityNameTextField = UITextField(frame: CGRect(x: 20, y: 250, width: 200, height: 40))
//        self.view.addSubview(cityNameTextField)
        
        // SnapKit 사용
        let firstLabel = UILabel()
        firstLabel.text = "지명을 입력하세요."
        firstLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(firstLabel)
        
        // make 클로저는 SnapKit에서 제공하는 문법, Auto Layout 제약 조건을 설정
        firstLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }
        
        cityNameTextField.borderStyle = .roundedRect
        cityNameTextField.backgroundColor = .systemGray6
        self.view.addSubview(cityNameTextField)
        
        cityNameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(30) // 아래로 30만큼 이동
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        let pushButton = UIButton()
        pushButton.setTitle("Button", for: .normal)
        pushButton.backgroundColor = .systemBlue
        pushButton.layer.cornerRadius = 10 // 모서리를 둥글게 만들기 위해
        self.view.addSubview(pushButton)
        
        pushButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(90)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        pushButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
    }
    
    @objc func tapButton() {
        if let cityNameTextField = self.cityNameTextField.text {
            self.getWeather(cityName: cityNameTextField)
        }
    }
    
    func getWeather(cityName: String) {
        let apiKey = "a8c1d55d8c112dbe5f0576f243f507ac"
        var components = URLComponents()
        
        let scheme = "https"
        let host = "api.openweathermap.org"
        
        components.scheme = scheme
        components.host = host
        components.path = "/data/2.5/weather"
        components.queryItems = [URLQueryItem(name: "q", value: cityName), URLQueryItem(name: "appid", value: apiKey)]
        
        let url = components.url!
        
        let request = URLRequest(url: url)
        
        let session = URLSession(configuration: .default)
            
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            guard let weatherModel = try? decoder.decode(WeatherModel.self, from: data) else { return }
            // debugPrint(weatherModel)
            guard let weatherDictionary = self.encodeModelToDictionary(model: weatherModel) else { return }
            self.resultViewController.weatherInfo = weatherDictionary
            //debugPrint(weatherDictionary)
            // 메인 스레드에서 작업
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(self.resultViewController, animated: true)
            }
        }.resume()
    }
    
    func encodeModelToDictionary<T: Codable>(model: T) -> [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(model) else {
               return nil
           }
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else {
               return nil
           }
        return dictionary
    }
    
}
