//
//  TabBarCoordinator.swift
//  SaleAirTickets
//
//  Created by Kos on 03.06.2024.
//

import UIKit

protocol TabBarCoordinatorProtocol:AnyObject {
    func pushAviaTickets()
    func pushHotel()
    func shot()
    func subscriptions()
    func profile()
}

final class TabBarCoordinator {
    
    //MARK: - Method
    
    private weak var parentCoordinator: MainProtocol?
    private var tabBarController: UITabBarController
    private var childCoordinators: [CoordinatorProtocol] = []
    
    //MARK: - Life Cycle
    
    init(parentCoordinator: MainProtocol, tabBarController: UITabBarController) {
        self.parentCoordinator = parentCoordinator
        self.tabBarController = tabBarController
    }
    
    private func createTabBar() -> UIViewController{
        
        let tabBarController = UITabBarController()
        
        let aviaTicketsCoordinator = AviaTicketsCoordinator(parentCoordinator: self)
        addChildCoordinator(aviaTicketsCoordinator)
        
        let hotelViewController = UIViewController()
        hotelViewController.view.backgroundColor = .black
        hotelViewController.tabBarItem = UITabBarItem(title: "Отели", image: UIImage(systemName: "bed.double.fill"), tag: 1)
        
        let shotViewController = UIViewController()
        shotViewController.view.backgroundColor = .black
        shotViewController.tabBarItem = UITabBarItem(title: "Короче", image: UIImage(named: "point"), tag: 2)
        
        let subscriptionsViewController = UIViewController()
        subscriptionsViewController.view.backgroundColor = .black
        subscriptionsViewController.tabBarItem = UITabBarItem(title: "Подписки", image: UIImage(systemName: "bell.fill"), tag: 3)
        
        let profileViewController = UIViewController()
        profileViewController.view.backgroundColor = .black
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 4)
        
        let controllers = [
            aviaTicketsCoordinator.start(),
            hotelViewController,
            shotViewController,
            subscriptionsViewController,
            profileViewController
        ]
        
        tabBarController.viewControllers = controllers
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.unselectedItemTintColor = .white
        self.tabBarController = tabBarController
        
        return tabBarController
    }
    
    private func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}

//MARK: - extension CoordinatorProtocol

extension TabBarCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createTabBar()
    }
}

//MARK: - extension TabBarCoordinatorProtocol

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    func pushAviaTickets() {
        
    }
    
    func pushHotel() {
        
    }
    
    func shot() {
        
    }
    
    func subscriptions() {
        
    }
    
    func profile() {
        
    }
    
    
    
    
}
