//
//  MainCoordinator.swift
//  SaleAirTickets
//
//  Created by Kos on 03.06.2024.
//

import UIKit

protocol MainProtocol: AnyObject {
    func nextFlow(from coordinator: CoordinatorProtocol)
}

final class MainCoordinator {
    
    //MARK: - Method
    var childCoordinators: [CoordinatorProtocol] = []
    var tabBarController = UITabBarController()
    
    private var rootViewController: UIViewController
    
    //MARK: - Life Cycle
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    //MARK: - Properties
    
    private func tabBarCoordinator() -> CoordinatorProtocol {
        let tabBarCoordinator = TabBarCoordinator(parentCoordinator: self, tabBarController: tabBarController)
        return tabBarCoordinator
    }
    
    private func showTabBarScreen() -> UIViewController {
        let coordinator = tabBarCoordinator()
        addChildCoordinator(coordinator)
        setFlow(to: coordinator.start())
        return rootViewController
    }
    
    private func setFlow(to newViewController: UIViewController) {
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.frame
        rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: rootViewController)
    }
    
    private func switchCoordinators(from previousCoordinator: CoordinatorProtocol, to nextCoordinator: CoordinatorProtocol) {
        addChildCoordinator(nextCoordinator)
        switchFlow(to: nextCoordinator.start())
        removeChildCoordinator(previousCoordinator)
    }
    
    private func switchFlow(to newViewController: UIViewController) {
        guard let currentViewController = rootViewController.children.first else {
            return
        }
        
        currentViewController.willMove(toParent: nil)
        currentViewController.navigationController?.isNavigationBarHidden = true
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.bounds
        
        rootViewController.transition(
            from: rootViewController.children[0],
            to: newViewController,
            duration: 0.5,
            options: [.transitionFlipFromRight]
        ) { [weak self] in
            guard let self else { return }
            currentViewController.removeFromParent()
            newViewController.didMove(toParent: rootViewController)
        }
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

extension MainCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        return showTabBarScreen()
    }
    
    
}

extension MainCoordinator: MainProtocol {
    func nextFlow(from coordinator: CoordinatorProtocol) {
        switch coordinator {
        case  let coordinator as TabBarCoordinator:
            switchCoordinators(from: coordinator, to: tabBarCoordinator())
        default:
            print("Error coordinators switching")
        }
    }
    

    


}
