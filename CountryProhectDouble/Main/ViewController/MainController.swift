//
//  MainController.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 23.02.2024.
//

import UIKit

protocol MainDelegateProtocol: AnyObject {
    func fetchCountrues(arrayCountryes: [Country])
    func fetchInvalid(error: NetworkError)
    
}


class MainController: UIViewController {
    
    //MARK: Properties
    private let storage = StorageManager.shared
    private var mainPresenter: MainPresenterProtocol
    private var searchCountryes = [Country]()
    private var countryes = [Country](){
        didSet {
            countryTable.reloadData()
        }
    }
  
    private var sections: [String]{
        return mainPresenter.fetchSections(arrayCountryes: countryes)
    }
    
    private var searchIsEmpty: Bool {
        guard let text = search.searchBar.text else {return true}
        return text.isEmpty
    }
    private var searchIsWorking: Bool{
        return !searchIsEmpty && search.isActive
    }
        
    //MARK: Private properties
    
    private lazy var countryTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(CountryCell.self, forCellReuseIdentifier: CountryCell.reuseId)
        return table
    }()
    
    private lazy var search: UISearchController = {
        let search = UISearchController()
        search.searchResultsUpdater = self
        return search
    }()
    
    init(mainPresenter: MainPresenterProtocol) {
        self.mainPresenter = mainPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Страны"
        addviews()
        applyConsttraints()
        navigationItem.searchController = search
//        try? mainPresenter.fetchCountryes()
    }
    
    //MARK: Addviews
    
    private func addviews(){
        view.addSubview(countryTable)
    }
    
    //MARK: Constraints
    
    private func applyConsttraints(){
        NSLayoutConstraint.activate([
            countryTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countryTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            countryTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            countryTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

    //MARK: Extantions country table

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let region = sections[section]
        let countryes = countryes.filter{country in country.region == region }
        return searchIsWorking ? searchCountryes.count : countryes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.reuseId, for: indexPath) as? CountryCell else {return UITableViewCell() }
        let region = sections[indexPath.section]
        let countryes = countryes.filter{country in country.region == region }
        var country = countryes[indexPath.row]
        if searchIsWorking {
            country = searchCountryes[indexPath.row]
        }
        let flag = mainPresenter.flag(country: country)
        cell.createCell(country: country, flag: flag)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchIsWorking ? 1 : sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchIsWorking ? nil : sections[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let region = sections[indexPath.section]
        let countryes = countryes.filter{country in country.region == region }
        var country = countryes[indexPath.row]
        if searchIsWorking {
            country = searchCountryes[indexPath.row]
        }
        let infoController = InfoController(country: country, infoPresener: InfoPresenter(storage: storage))
        navigationController?.pushViewController(infoController, animated: true)
        
    }
}

extension MainController: MainDelegateProtocol {
  
    
    func fetchCountrues(arrayCountryes: [Country]) {
        self.countryes = arrayCountryes
    }
    
    func fetchInvalid(error: NetworkError) {
        print(error.localizedDescription)
    }
}

extension MainController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        filteredSearch(text: text)
    }
    
    private func filteredSearch(text: String){
        
        searchCountryes = countryes.filter{ country in
            guard let name = country.name?.common else {return false}
            return name.lowercased().starts(with: text.lowercased())
        }
        countryTable.reloadData()
    }
}
