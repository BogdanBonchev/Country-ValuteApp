//
//  TabBarController.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 23.02.2024.
//

import UIKit


class TabBarController: UITabBarController {
    
    private let storage = StorageManager.shared
    
    //MARK: Resurce for bar items
    
    private enum BarItem: Int {
        case main
        case map
        
        var title: String{
            switch self {
            case .main:
                return "Страны"
            case .map:
                return "Карта"
            }
        }
        var image: UIImage? {
            switch self {
            case .main:
                return UIImage(systemName: "sportscourt.fill")
            case .map:
                return UIImage(systemName: "map.fill")
            }
        }
    }
    
    //MARK: Initional
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private functions
    
    private func configure(){
        tabBar.barTintColor = .white
        tabBar.tintColor = .blue
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        
        tabBar.scrollEdgeAppearance = appearance
        tabBar.standardAppearance = appearance
        
        
        let mainPresenter = MainPresenter(networkManager: NetworkManager(), apiManager: ApiManager(), storage: storage)
        let mainController = MainController(mainPresenter: mainPresenter)
        mainPresenter.delegate = mainController
        
        let valutePresenter = ValutePresenter(networkManager: NetworkManager(), apiManager: ApiManager())
        let valuteController = ValuteController(valutePresenter: valutePresenter)
        valutePresenter.delegate = valuteController

        
        let mainNav = UINavigationController(rootViewController: mainController)
        let valuteNav = UINavigationController(rootViewController: valuteController)
        
        mainNav.tabBarItem = createBarItem(type: .main)
        valuteNav.tabBarItem = createBarItem(type: .map)
        
        setViewControllers([
        mainNav,
        valuteNav
        ], animated: true)
    }
    
    private func createBarItem (type: BarItem) -> UITabBarItem {
        return UITabBarItem(title: type.title, image: type.image, tag: type.rawValue)
    }
}
