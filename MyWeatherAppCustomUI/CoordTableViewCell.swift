//
//  CoordTableViewCell.swift
//  MyWeatherAppCustomUI
//
//  Created by jhchoi on 2023/06/20.
//

import UIKit
import SnapKit

class CoordTableViewCell: UITableViewCell {
    
    static let id = "CoordTableViewCell"
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = CGRect(x: 10, y: 0, width: 200, height: contentView.frame.height)
//    }

    // 이 클로저는 UILabel 인스턴스를 초기화하고, 초기 설정을 수행한 후에 해당 인스턴스를 latLabel 상수에 할당
    let latLabel: UILabel = {
        let label = UILabel()
//        label.setContentHuggingPriority(.required, for: .horizontal)
//        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let lonLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()

    // latLabel과 lonLabel을 각각 초기화한 후에 stackView를 초기화
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [latLabel, lonLabel])
        stackView.backgroundColor = .systemBackground
        stackView.alignment = .center
        return stackView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        labelSetup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func labelSetup() {
        
        //        contentView.addSubview(latLabel)
        //        contentView.addSubview(lonLabel)
        //
        //        latLabel.snp.makeConstraints { make in
        //            make.leading.equalToSuperview()
        //            make.top.equalToSuperview()
        //        }
        //
        //        lonLabel.snp.makeConstraints { make in
        //            make.leading.equalToSuperview()
        //            make.top.equalToSuperview()
        //        }
        
//        self.backgroundColor = UIColor.clear
//        self.contentView.backgroundColor = UIColor.clear
        
    
        contentView.addSubview(stackView)
        
        // addSubview를 하고 나서 Constraints를 설정해야 한다. 순서 매우 중요
//        stackView.snp.makeConstraints { make in
//            //make.top.left.bottom.right.equalTo(contentView)
//            //make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
////            make.centerX.equalTo(contentView.snp.centerX)
////            make.centerY.equalTo(contentView.snp.centerY)
//            make.height.equalTo(contentView.snp.height)
//            make.leading.equalTo(contentView.snp.leading).offset(20)
//            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
//        }
//
////        latLabel.snp.makeConstraints { make in
////            make.width.equalTo(10)
////        }
//
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        lonLabel.snp.makeConstraints { make in
            make.width.equalTo(latLabel)
        }


//
//        stackView.backgroundColor = .clear
//
//        // 둥근 테두리 설정
//        stackView.layer.cornerRadius = 10.0
//        stackView.layer.masksToBounds = true
//
//        // 테두리 선 설정
//        stackView.layer.borderColor = UIColor.black.cgColor
//        stackView.layer.borderWidth = 1.0

    }

}
