//
//  ApiManager.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 24.02.2024.
//

import UIKit

enum TypeUrl {
    case country
    case valute
    
    var url: String {
        switch self {
        case .country:
            return "https://restcountries.com/v3.1/all"
        case .valute:
            return "https://www.cbr-xml-daily.ru/daily_json.js"
        }
    }
}

protocol ApiManagerProtocol {
    func fechUrl(type: TypeUrl) -> String
}

class ApiManager: ApiManagerProtocol {
    let urlComponents = URLComponents()
    
    func fechUrl(type: TypeUrl) -> String {
        return type.url
    }
}

