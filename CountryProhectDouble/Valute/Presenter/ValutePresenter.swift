//
//  ValutePresenter.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 26.02.2024.
//

import UIKit

protocol ValutePresenterProtocol{
    func fetchValutes()
    
}

protocol valutePresenterDeleagate: AnyObject{
    func acceptCurrencies(valute: [Valute])
    func fetchError(error: NetworkError)
}

class ValutePresenter: ValutePresenterProtocol {
    
    
    
    weak var delegate: valutePresenterDeleagate?
 
    private var networkManager: NemworkManagerProtocol
    private var apiManager: ApiManagerProtocol
    
    init(networkManager: NemworkManagerProtocol, apiManager: ApiManagerProtocol) {
        
        self.networkManager = networkManager
        self.apiManager = apiManager
    
    }
    
    func fetchValutes() {
        let urlString = apiManager.fechUrl(type: .valute)
        guard let urlValutes = URL(string: urlString) else {
            self.delegate?.fetchError(error: .invalidUrl)
            return
        }
        networkManager.fetchData(url: urlValutes) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let courseData = try JSONDecoder().decode(CourseData.self, from: data).Valute
                    let valutes = courseData.map{ $0.value }
                    self?.delegate?.acceptCurrencies(valute: valutes)
                }
                catch {
                    self?.delegate?.fetchError(error: .noData)
                }
            case .failure(let error):
                self?.delegate?.fetchError(error: error)
            }
        }
    }
    
    
    
    
}
