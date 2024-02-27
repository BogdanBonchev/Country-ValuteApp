//
//  StorageManager.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 25.02.2024.
//

import UIKit

protocol StorageManagerProtocol {
    var flag: [String:UIImage?] {get}
    var gerb: [String:UIImage?] {get}
    func flag(country: Country) -> UIImage?
    func saveFlag(country: Country, image: UIImage?) 
    func gerb(country: Country) -> UIImage?
    func saveGerb(country: Country, image: UIImage?)
}

class StorageManager: StorageManagerProtocol {
  
    static var shared = StorageManager()
    var icon = [String:UIImage?]()
    var flag = [String:UIImage?]()
    var gerb = [String:UIImage?]()
    
    private init(){}
    
    func flag(country: Country) -> UIImage? {
        guard let name = country.name?.common else { return nil }
        return flag[name] ?? nil
    }
    
    func saveFlag(country: Country, image: UIImage?) {
        guard let name = country.name?.common else { return }
        flag[name] = image
        
    }
    
    func gerb(country: Country) -> UIImage? {
        guard let gerbCountry = country.coatOfArms?.png else { return nil }
        return gerb[gerbCountry] ?? nil
    }
    
    func saveGerb(country: Country, image: UIImage?) {
        guard let gerbCountry = country.coatOfArms?.png else { return }
        gerb[gerbCountry] = image
    }
}
