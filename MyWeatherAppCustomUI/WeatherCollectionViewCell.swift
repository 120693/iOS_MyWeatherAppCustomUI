//
//  WeatherCollectionViewCell.swift
//  MyWeatherAppCustomUI
//
//  Created by jhchoi on 2023/06/28.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let id = "WeatherCollectionViewCell"
    
    let NameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.backgroundColor = .purple
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubview(NameLabel)
        contentView.addSubview(numberLabel)
        
        NameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(NameLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            //make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(100)
        }
    }
}
