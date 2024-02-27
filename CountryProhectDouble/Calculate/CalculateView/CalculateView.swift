//
//  CalculateView.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 27.02.2024.
//

import UIKit


class CalculateView: UIViewController {
    
    private let valute: Valute
    
    private var nameLabel = UILabel(text: "", font: .systemFont(ofSize: 32, weight: .bold), textAlignment: .center)
    private var IDLAbel = UILabel(text: "", font: .systemFont(ofSize: 21), textAlignment: .left)
    private var NumCodeLAbel = UILabel(text: "", font: .systemFont(ofSize: 21), textAlignment: .left)
    private var CharCodeLAbel = UILabel(text: "", font: .systemFont(ofSize: 21), textAlignment: .left)
    private var PreviousLAbel = UILabel(text: "", font: .systemFont(ofSize: 21), textAlignment: .left)
    private var NominalTextLabel = UILabel(text: "", font: .systemFont(ofSize: 24), textAlignment: .center)
    private var ValuteLabel = UILabel(text: "", font: .systemFont(ofSize: 24), textAlignment: .center)
    
    private lazy var valuteStack = UIStackView(arrangedSubviews: [ IDLAbel, NumCodeLAbel, CharCodeLAbel, PreviousLAbel], axis: .vertical, spacing: 10, alignment: .fill)
    private lazy var convertStack = UIStackView(arrangedSubviews: [ NominalTextLabel, ValuteLabel], axis: .vertical, spacing: 10, alignment: .fill)
   
    init(valute: Valute) {
        self.valute = valute
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addviews()
        applyConstraints()
        fetchValute()
        gastureIncognaizer()
    }
    
    private func addviews(){
        view.addSubview(nameLabel)
        view.addSubview(valuteStack)
        view.addSubview(convertStack)
        
    }
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 250),
            
            valuteStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            valuteStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            valuteStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
  
            convertStack.topAnchor.constraint(equalTo: valuteStack.bottomAnchor, constant: 50),
            convertStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            convertStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        ])
    }
    
    private func fetchValute(){
        nameLabel.text = valute.Name
        IDLAbel.text = "ID валюты: " + valute.ID
        NumCodeLAbel.text = "Код: " + valute.NumCode
        CharCodeLAbel.text = "Абревиатура: " + valute.CharCode
        PreviousLAbel.text = String(valute.Previous)
        NominalTextLabel.text = "Расчитать курс \n \(self.valute.Name): " + String(valute.Nominal)
        ValuteLabel.text = String(valute .Value) + " Рублей"
    }
    
    
    private func gastureIncognaizer(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureTap))
        NominalTextLabel.isUserInteractionEnabled = true
        NominalTextLabel.addGestureRecognizer(gesture)
        gesture.numberOfTapsRequired = 1
    }
    
    @objc private func gestureTap(){
        let alert = UIAlertController(title: "\(self.valute.Name)", message: "Ведите количество", preferredStyle: .alert)
     
        alert.addTextField { tfAlert in
            tfAlert.placeholder = ""
        }
        
        
        let ok = UIAlertAction(title: "Готово", style: .default) { action in
             let tfText = alert.textFields?.first
            guard let text = tfText?.text else { return }
            self.NominalTextLabel.text = "Расчитать курс \n \(self.valute.Name): " + text
            guard let double = Float(text) else { return }
            let convert = double * Float(self.valute.Value)
            self.ValuteLabel.text = "\(String(convert)) Рублей"
        }
        let cancel = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
