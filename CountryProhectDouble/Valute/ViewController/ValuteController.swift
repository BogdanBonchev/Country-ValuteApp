//
//  VuluteController.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 23.02.2024.
//

import UIKit
import MapKit

class ValuteController: UIViewController {
    
    private var searchValute = [Valute]()
    private var valuteArray = [Valute]() {
        didSet {
            DispatchQueue.main.async {
                self.valuteCollection.reloadData()
            }
        }
    }
    
    private var searchIsEmpty: Bool {
        guard let text = search.searchBar.text else {return true}
        return text.isEmpty
    }
    private var searchIsWorking: Bool {
        return !searchIsEmpty && search.isActive
    }
    
    private lazy var search: UISearchController = {
       let search = UISearchController()
        search.searchResultsUpdater = self
        return search
    }()
    
    var valutePresenter: ValutePresenterProtocol
    
    private lazy var valuteCollection: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = .init(width: 170, height: 140)
        collectionViewLayout.minimumLineSpacing = 5
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.sectionInset = .init(top: 5, left: 20, bottom: 5, right: 20)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ValuteCell.self, forCellWithReuseIdentifier: ValuteCell.reuseId)
        return collection
    }()
    
    init(valutePresenter: ValutePresenterProtocol) {
        self.valutePresenter = valutePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Курс валют"
        valutePresenter.fetchValutes()
        addsabviews()
        applyConstraints()
        navigationItem.searchController = search
    }
    private func addsabviews(){
        view.addSubview(valuteCollection)
    }
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            valuteCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            valuteCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            valuteCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            valuteCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

extension ValuteController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchIsWorking ? searchValute.count : valuteArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ValuteCell.reuseId, for: indexPath) as? ValuteCell else {return UICollectionViewCell()}
        var valute = valuteArray[indexPath.item]
        if searchIsWorking {
            valute = searchValute[indexPath.item]
        }
        cell.setup(with: valute)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var valute = valuteArray[indexPath.item]
        if searchIsWorking {
            valute = searchValute[indexPath.item]
        }
        let calculateValute = CalculateView(valute: valute)
        navigationController?.pushViewController(calculateValute, animated: true)
    }
}


extension ValuteController: valutePresenterDeleagate{
    
    func acceptCurrencies(valute: [Valute]) {
        self.valuteArray = valute
    }
    
    func fetchError(error: NetworkError) {
        print(error)
    }
}

extension ValuteController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        filteredValute(with: text)
    }
    private func filteredValute(with text: String) {
        searchValute = valuteArray.filter{ valute in
            valute.Name.lowercased().starts(with: text.lowercased())
        }
        self.valuteCollection.reloadData()
    }
    
}
