//
//  ValuteModel.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 26.02.2024.
//

import Foundation



struct CourseData : Codable {
    let Valute: [String:Valute]
}

struct Valute: Codable {
    let ID: String
    let NumCode: String
    let CharCode: String
    let Nominal: Int
    let Name: String
    let Value: Double
    let Previous: Double
}

