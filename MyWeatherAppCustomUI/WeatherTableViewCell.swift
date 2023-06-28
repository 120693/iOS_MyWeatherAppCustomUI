//
//  WeatherTableViewCell.swift
//  MyWeatherAppCustomUI
//
//  Created by jhchoi on 2023/06/28.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let id = "WeatherTableViewCell"
    
    let customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumInteritemSpacing = 10
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
        
        customCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
        
        customCollectionView.backgroundColor = .clear
        
        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        customCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        customCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        customCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        customCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        customCollectionView.heightAnchor.constraint(equalToConstant: 315).isActive = true
        
        customCollectionView.dataSource = self
    }
}

extension WeatherTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as! WeatherCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.purple.cgColor
        cell.layer.borderWidth = 2.0
        
        switch indexPath.row  {
        case 0:
            cell.NameLabel.text = " 👀 가시거리"
            cell.numberLabel.text = "16KM"
            return cell
        case 1:
            cell.NameLabel.text = " ☀️ 자외선 지수"
            cell.numberLabel.text = "낮음"
            return cell
        case 2:
            cell.NameLabel.text = " 🌇 일몰"
            cell.numberLabel.text = "오후 7시 56분"
            return cell
        case 3:
            cell.NameLabel.text = " 🌬️ 대기질"
            cell.numberLabel.text = "보통"
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
