//
//  MainPresenter.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 24.02.2024.
//

import UIKit

protocol MainPresenterProtocol{
    var storage: StorageManagerProtocol {get}
    func fetchCountryes() throws
    func fetchSections(arrayCountryes: [Country]) -> [String]
    func flag(country: Country)-> UIImage?
}

class MainPresenter: MainPresenterProtocol {
    private(set) var storage: StorageManagerProtocol
    weak var delegate: MainDelegateProtocol?
    private var networkManager: NemworkManagerProtocol
    private var apiManager: ApiManagerProtocol
    
    init(networkManager: NemworkManagerProtocol, apiManager: ApiManagerProtocol, storage: StorageManagerProtocol) {
        self.networkManager = networkManager
        self.apiManager = apiManager
        self.storage = storage
    }

    func fetchCountryes() throws {
        let urlString = apiManager.fechUrl(type: .country)
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidUrl
        }
            networkManager.fetchData(url: url) { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let loadingQueue = DispatchQueue(label: "com.bonchev.loadingQueue-concurrent", attributes: .concurrent)
                        let dispatchGroup = DispatchGroup()
                        let countryes = try JSONDecoder().decode([Country].self, from: data)
                        let regions = self?.fetchSections(arrayCountryes: countryes)
                        let sortedCountryes = countryes.sorted{ country,_ in
                            return country.region == regions?.first
                        }
                        for country in sortedCountryes {
                            loadingQueue.async {
                                if country.region == regions?.first {
                                    dispatchGroup.enter()
                                    dispatchGroup.enter()
                                }
                                self?.updateFlag(country: country){
                                    if country.region == regions?.first {
                                        dispatchGroup.leave()
                                    }
                                } 
                                self?.updateGerb(country: country){
                                    if country.region == regions?.first {
                                        dispatchGroup.leave()
                                    }
                                }
                            }
                        }
                        dispatchGroup.notify(queue: .main){
                            let sortedContryes = countryes.sorted{$0.name?.common ?? "" < $1.name?.common ?? ""}
                            self?.delegate?.fetchCountrues(arrayCountryes: sortedContryes)
                        }
                    }
                    catch {
                        self?.delegate?.fetchInvalid(error: NetworkError.noData)
                    } 
                case .failure(let error):
                        self?.delegate?.fetchInvalid(error: error)
            }
        }
       
    }
    
    private func updateFlag(country: Country, copletion: @escaping()->Void){
        guard let png = country.flags?.png, let url = URL(string: png) else { return }
        networkManager.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                self.storage.saveFlag(country: country, image: image)
            case .failure(let error):
                self.delegate?.fetchInvalid(error: error)
            }
            copletion()
        }
    }
    
    private func updateGerb(country: Country, comletion: @escaping()-> Void) {
        guard let png = country.coatOfArms?.png, let pngUrl = URL(string: png) else {
            comletion()
            return
        }
        networkManager.fetchData(url: pngUrl) { result in
            switch result {
                case .success(let data):
                let image = UIImage(data: data)
                self.storage.saveGerb(country: country, image: image)
            case .failure(let error):
                self.delegate?.fetchInvalid(error: error)
            }
            comletion()
        }
    }
    
    func fetchSections(arrayCountryes: [Country]) -> [String] {
        var sections = Set<String>()
        for country in arrayCountryes {
            sections.insert(country.region ?? "")
        }
        return sections.sorted{$0 < $1}
    }
    
    func flag(country county: Country)-> UIImage? {
        return storage.flag(country: county)
    }
    
}
