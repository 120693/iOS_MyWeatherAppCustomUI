//
//  MainCollectionViewCell.swift
//  MyWeatherAppCustomUI
//
//  Created by jhchoi on 2023/06/27.
//

import UIKit
import SwiftUI
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let id = "MainCollectionViewCell"
    
    let NameLabel: UILabel = {
        let label = UILabel()
        //label.frame = CGRect(x: 0, y: 20, width: 150, height: 50)
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        //label.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
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
    
        addSubview(NameLabel)
        addSubview(numberLabel)
        
//        feelsLikeNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        feelsLikeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        feelsLikeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        feelsLikeNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        feelsLikeNameLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
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


