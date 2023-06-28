//
//  WeekTableViewCell.swift
//  MyWeatherAppCustomUI
//
//  Created by jhchoi on 2023/06/22.
//

import UIKit

class WeekTableViewCell: UITableViewCell {

    static let id = "WeekTableViewCell"
    
    let dayName: UILabel = {
      let label = UILabel()
        return label
    }()
    
    let dayIcon: UIImageView = {
       let image = UIImageView()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dayName)
        contentView.addSubview(dayIcon)
        
        
        dayName.translatesAutoresizingMaskIntoConstraints = false
        dayName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        dayName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        dayIcon.translatesAutoresizingMaskIntoConstraints = false
        dayIcon.leadingAnchor.constraint(equalTo: dayName.trailingAnchor, constant: 10).isActive = true
        dayIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        dayIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dayIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
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

}
