//
//  CountryCell.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 24.02.2024.
//

import UIKit

class CountryCell: UITableViewCell {
    
    //MARK: Private properties
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let imageFlag: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    //MARK: Initional
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Addviews
    
    private func addviews(){
        contentView.addSubview(imageFlag)
        contentView.addSubview(nameLabel)
    }
    
    //MARK: Constraints
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            imageFlag.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageFlag.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            imageFlag.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            imageFlag.widthAnchor.constraint(equalToConstant: 120),
            imageFlag.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.centerYAnchor.constraint(equalTo: imageFlag.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: imageFlag.leadingAnchor, constant: -10)
            
        ])
    }
    
    //MARK: Private functions
    
     func createCell(country: Country, flag: UIImage?){
        nameLabel.text = country.name?.common ?? ""
        imageFlag.image = flag
        
    }
}
