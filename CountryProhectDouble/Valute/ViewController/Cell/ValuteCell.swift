//
//  ValuteCell.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 26.02.2024.
//

import UIKit


class ValuteCell: UICollectionViewCell {
    
     //var valute: Valute
    
    private let nameValuteLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textAlignment: .center)
    private let nominalValuteLabel = UILabel(text: "", font: .systemFont(ofSize: 12), textAlignment: .center)
    private let convertValuteLabel = UILabel(text: "", font: .systemFont(ofSize: 12), textAlignment: .center)
    
    private let imageCountry: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = .init(x: 0, y: 0, width: 20, height: 20)
        return image
    }()
    
    private lazy var valuteStack = UIStackView(arrangedSubviews: [imageCountry, nameValuteLabel,nominalValuteLabel, convertValuteLabel], axis: .vertical, spacing: 5, alignment: .top)

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.borderColor = UIColor.systemYellow.cgColor
        addviews()
        applyconstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addviews(){
        contentView.addSubview(valuteStack)
    }
    private func applyconstraints(){
        NSLayoutConstraint.activate([
            valuteStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            valuteStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            valuteStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
            valuteStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    func setup(with valute: Valute){
        nameValuteLabel.text = valute.Name
        nominalValuteLabel.text = "\(valute.Name): " + String(valute.Nominal)
        convertValuteLabel.text =  String(valute.Value) + " Рублей" 
    }
}


