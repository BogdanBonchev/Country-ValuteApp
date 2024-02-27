//
//  ReuseId.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 23.02.2024.
//

import UIKit

extension UITableViewCell {
    static var reuseId: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var reuseId: String {
        return String(describing: self)
    }
}
