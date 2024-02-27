//
//  InfoController.swift
//  ContryProject
//
//  Created by Богдан Бончев on 28.01.2024.
//

import UIKit

class InfoController : UIViewController {
    
    //MARK: - Properties
    
    private let country : Country
    private let infoPresenter: InfoPresenterProtocol
    
    //MARK: - Init properties
    
    init(country : Country, infoPresener: InfoPresenterProtocol){
        self.country = country
        self.infoPresenter = infoPresener
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    
    private var contryNameLabel: UILabel = {
        let  lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.textAlignment = .center
        return lbl
    }()
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.layer.borderWidth = 4
        image.layer.borderColor = UIColor.darkGray.cgColor
        return image
    }()
    private var flagLabel: UILabel = {
        let  lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "Флаг страны"
        lbl.font = .systemFont(ofSize: 28, weight: .medium)
        return lbl
    }()
    private  var imageGerbView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        return image
    }()
    private var gerbLabel: UILabel = {
        let  lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "Герб страны"
        lbl.font = .systemFont(ofSize: 28, weight: .medium)
        return lbl
    }()
    private var capitalLabel: UILabel = {
        let  lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        return lbl
    }()
    private var regionLabel: UILabel = {
        let  lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        return lbl
    }()
    private var subregionLavel: UILabel = {
        let  lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        return lbl
    }()
    private var languelLabel: UILabel = {
        let  lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        return lbl
    }()
//    private var curentlLabel: UILabel = {
//        let  lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.textAlignment = .left
//        lbl.numberOfLines = 1
//        lbl.font = .systemFont(ofSize: 20, weight: .medium)
//        return lbl
//    }()
    private var populationLabel: UILabel = {
        let  lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        return lbl
    }()
    private var altFlagLabel: UILabel = {
        let  lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 17, weight: .heavy)
        lbl.backgroundColor = .systemBackground
        lbl.textColor = .black
        lbl.layer.cornerRadius = 5
        lbl.layer.masksToBounds = true
        lbl.layer.borderColor = UIColor.darkGray.cgColor
        lbl.layer.borderWidth = 2
        return lbl
    }()
    
    //MARK: - Life view
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        applyConstraints()
        setupUI()
        gestureRecognaizer()
    }
    
    //MARK: - addSubviews
    
    private func addSubviews(){
        view.addSubview(contryNameLabel)
        view.addSubview(imageView)
        view.addSubview(flagLabel)
        view.addSubview(imageGerbView)
        view.addSubview(gerbLabel)
        view.addSubview(capitalLabel)
        view.addSubview(regionLabel)
        view.addSubview(subregionLavel)
        view.addSubview(languelLabel)
//        view.addSubview(curentlLabel)
        view.addSubview(populationLabel)
    }
    
    //MARK: - Constrints
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            
            contryNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            contryNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            contryNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
            imageView.topAnchor.constraint(equalTo: contryNameLabel.bottomAnchor,constant: 50),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 130),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            flagLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            flagLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            flagLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor,constant: -16),
            
            imageGerbView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            imageGerbView.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 20),
            imageGerbView.widthAnchor.constraint(equalToConstant: 80),
            imageGerbView.heightAnchor.constraint(equalToConstant: 70),
            
            
            gerbLabel.centerYAnchor.constraint(equalTo: imageGerbView.centerYAnchor),
            gerbLabel.centerXAnchor.constraint(equalTo: flagLabel.centerXAnchor),
            
            capitalLabel.topAnchor.constraint(equalTo: imageGerbView.bottomAnchor,constant: 25),
            capitalLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            capitalLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
            regionLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor,constant: 25),
            regionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            regionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
            subregionLavel.topAnchor.constraint(equalTo: regionLabel.bottomAnchor,constant: 25),
            subregionLavel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            subregionLavel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
            languelLabel.topAnchor.constraint(equalTo: subregionLavel.bottomAnchor,constant: 25),
            languelLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            languelLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
//            curentlLabel.topAnchor.constraint(equalTo: languelLabel.bottomAnchor,constant: 25),
//            curentlLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
//            curentlLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
            populationLabel.topAnchor.constraint(equalTo: languelLabel.bottomAnchor,constant: 25),
            populationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            populationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
        ])
    }
    
    
    //MARK: - Private functions
    
     func setupUI() {
        altFlagLabel.text = country.flags?.alt ?? "Нет информации"
        capitalLabel.text = "Официальная столица страны:  \n \(country.capital?.first ?? "Нет информации")"
        regionLabel.text = "Страна относится к региону: \(country.region ?? "Нет информации")"
        contryNameLabel.text = "\(country.name?.official ?? "Нет информации")"
        subregionLavel.text = "Суб регион: \(country.subregion ?? "Нет информации")"
        populationLabel.text = "Численность населения: \(country.population ?? 0) человек"
        let langue = country.languages?.first?.value ?? ""
        languelLabel.text = "В стране используют языки : \(langue)"
//         curentlLabel.text = "Валюта в стране: \(String(describing: country.currencies))"
         self.imageView.image = infoPresenter.flag(country: country)
         imageGerbView.image = infoPresenter.gerb(country: country)
    }
    
    private func gestureRecognaizer() {
        let tapGestureRecognaizer = UITapGestureRecognizer(target: self, action: #selector(pressentAltFlags))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognaizer)
        tapGestureRecognaizer.numberOfTapsRequired = 1
    }
    
    //MARK: - Actions
    
    @objc private func pressentAltFlags() {
        let alert = UIAlertController(title: altFlagLabel.text, message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}


