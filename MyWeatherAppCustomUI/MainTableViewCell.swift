//
//  MainTableViewCell.swift
//  MyWeatherAppCustomUI
//
//  Created by jhchoi on 2023/06/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let id = "MainTableViewCell"
    
    var feelsLikeData: String?
    var humidityData: String?
    var minTempData: String?
    var maxTempData: String?
    
    let customCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setUp() {
        contentView.addSubview(customCollectionView)
        
        customCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        
        customCollectionView.backgroundColor = .clear
        
        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        customCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        customCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        customCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        customCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        customCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //customCollectionView.contentSize = CGSize(width: 600, height: 150)
        
        customCollectionView.dataSource = self
        //customCollectionView.delegate = self
        

        
    }
    
    public func mainConfigure(with data: [String: Any]) {
        if let feelsLike = data["feels_like"] as? Double {
            feelsLikeData = String(format:"%.2f", kToC(kelvin: feelsLike)) + "°C"
        }
        
        if let humidity = data["humidity"] as? Double {
            humidityData = String(humidity) + "%"
        }
        
        if let minTemp = data["temp_min"] as? Double {
            minTempData = String(format:"%.2f", kToC(kelvin: minTemp)) + "°C"
        }
        
        if let maxTemp = data["temp_max"] as? Double {
            maxTempData = String(format:"%.2f", kToC(kelvin: maxTemp)) + "°C"
        }
    }
}

extension MainTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return 4
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as! MainCollectionViewCell
        
        //cell.backgroundColor = .orange
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 2.0
        
        switch indexPath.row {
        case 0:
            cell.NameLabel.text = " 🌡️ 체감온도"
            cell.numberLabel.text = feelsLikeData
            return cell
        case 1:
            cell.NameLabel.text = " 💧 습도"
            cell.numberLabel.text = humidityData
            return cell
        case 2:
            cell.NameLabel.text = " ⬇️ 최저기온"
            cell.numberLabel.text = minTempData
            return cell
        case 3:
            cell.NameLabel.text = " ⬆️ 최고기온"
            cell.numberLabel.text = maxTempData
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

