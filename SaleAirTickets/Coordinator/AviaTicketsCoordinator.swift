//
//  AviaTicketsCoordinator.swift
//  SaleAirTickets
//
//  Created by Kos on 03.06.2024.
//

import UIKit


protocol AviaTicketsProtocol: AnyObject {
    func nextFlow()
}

final class AviaTicketsCoordinator {
    
    //MARK: - Method
    
    private weak var parentCoordinator: TabBarCoordinatorProtocol?
    private var navigationController: UINavigationController?
    private var rootViewController: UIViewController?
    
    //MARK: - Life cycle
    
    init(parentCoordinator: TabBarCoordinatorProtocol) {
        self.parentCoordinator = parentCoordinator
    }
    
    //MARK: - Properties
    
    private func createNavigationController() -> UIViewController {
        let mapper = CoreMapper()
        let networkManager = CoreNetworkManager()
        let apiService = OffersApiService(mapper: mapper, networkManager: networkManager)
        let viewModel = AviaTicketsModel(coordinator: self, apiService: apiService)
        let aviaTicketsViewController = AviaTicketsViewController(viewModel: viewModel)
        rootViewController = aviaTicketsViewController
        aviaTicketsViewController.view.backgroundColor = .black
        let navigationController = UINavigationController(rootViewController: aviaTicketsViewController)
        navigationController.tabBarItem = UITabBarItem(title: "Авиябилеты", image: UIImage(named: "airplan"), tag: 0)
        self.navigationController = navigationController
        return navigationController
    }
    
    func presentChildViewController(_ viewController: UIViewController) {
        navigationController?.present(viewController, animated: true, completion: nil)
   }
}

//MARK: - extension CoordinatorProtocol

extension AviaTicketsCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

//MARK: - extension AviaTicketsProtocol

extension AviaTicketsCoordinator: AviaTicketsProtocol {
    func nextFlow() {
        let searchForTicketsCoordinator = SearchForTicketsCoordinator(parentCoordinator: self)
        let searchForTicketsVC = searchForTicketsCoordinator.start()
        self.presentChildViewController(searchForTicketsVC)
    }
}
