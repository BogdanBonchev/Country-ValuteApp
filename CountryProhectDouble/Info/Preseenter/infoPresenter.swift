//
//  infoPresenter.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 25.02.2024.
//

import UIKit

protocol InfoPresenterProtocol {
    func flag(country: Country) -> UIImage?
    func gerb(country: Country)-> UIImage? 
}

class InfoPresenter: InfoPresenterProtocol {
    
    private let storage: StorageManagerProtocol
    
    init(storage: StorageManagerProtocol) {
        self.storage = storage
    }
    
    func flag(country: Country) -> UIImage? {
        return storage.flag(country: country)
    }
    
    func gerb(country: Country)-> UIImage? {
        return storage.gerb(country: country)
    }
}
