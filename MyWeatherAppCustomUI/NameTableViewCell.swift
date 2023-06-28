//
//  NameTableViewCell.swift
//  MyWeatherAppCustomUI
//
//  Created by jhchoi on 2023/06/21.
//

import UIKit
import SnapKit

class NameTableViewCell: UITableViewCell {
    
    static let id = "NameTableViewCell"

    let cityNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    let tempLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let iconImageView: UIImageView = {
       let imageView = UIImageView()
        
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let maxTempLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var firstInnerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [tempLabel, iconImageView])
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var secondInnerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [maxTempLabel, minTempLabel])
        stackView.spacing = 10
        
        return stackView
    }()
    
    lazy var outerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [cityNameLabel, firstInnerStackView, descriptionLabel, secondInnerStackView])
        stackView.backgroundColor = .systemBackground
        stackView.alignment = .center
        stackView.spacing = 30
        stackView.axis = .vertical
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        viewSetup()
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
    
    func viewSetup() {
        contentView.addSubview(outerStackView)
        
        outerStackView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalTo(contentView)
        }
    }

}
