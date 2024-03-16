//
//  StorageManager.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 25.02.2024.
//

import UIKit

protocol StorageManagerProtocol {
    func flag(country: Country) -> UIImage?
    func saveFlag(country: Country, image: UIImage?) 
    func gerb(country: Country) -> UIImage?
    func saveGerb(country: Country, image: UIImage?)
    var flagCach: NSCache<NSString, UIImage> {get}
    var gerbCach: NSCache<NSString, UIImage> {get}
}

class StorageManager: StorageManagerProtocol {
    
    var gerbCach = NSCache<NSString, UIImage>()
    var flagCach = NSCache<NSString, UIImage>()
    
    static var shared = StorageManager()
    
    private init(){}
    
    func flag(country: Country) -> UIImage? {
        guard let name = country.name?.common else { return nil }
        return flagCach.object(forKey: name as NSString)
    }
    
    func saveFlag(country: Country, image: UIImage?) {
        guard let name = country.name?.common, let image = image else { return }
        flagCach.setObject(image, forKey: name as NSString)
    }
    
    func gerb(country: Country) -> UIImage? {
        guard let gerbCountry = country.coatOfArms?.png else { return nil }
        return gerbCach.object(forKey: gerbCountry as NSString)
    }
    
    func saveGerb(country: Country, image: UIImage?) {
        guard let gerbCountry = country.coatOfArms?.png,
              let imageGerb = image else { return }
        gerbCach.setObject(imageGerb, forKey: gerbCountry as NSString)
    }
}
