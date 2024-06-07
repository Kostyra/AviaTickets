//
//  SearchForTicketsCoordinator.swift
//  SaleAirTickets
//
//  Created by Kos on 06.06.2024.
//

import UIKit

protocol SearchForTicketsProtocol: AnyObject {
    func nextFlow()
}

final class SearchForTicketsCoordinator {
    
    private weak var parentCoordinator: AviaTicketsProtocol?
    private var rootViewController: UIViewController?

    init(parentCoordinator: AviaTicketsProtocol) {
        self.parentCoordinator = parentCoordinator
    }
    
    private func createNavigationController() -> UIViewController {
        let mapper = CoreMapper()
        let networkManager = CoreNetworkManager()
        let apiService = TicktesOfferApiService(mapper: mapper, networkManager: networkManager)
        let viewModel = SearchForTicketsModel(apiService: apiService, coordinator: self)
        var mainMenu: [MenuItem] { MenuItem.make() }
        var mainMenuTable: [MenuItemTable] { MenuItemTable.make() }
        let searchForTicketsVC = SearchForTicketsController(viewModel: viewModel, mainMenu: mainMenu, mainMenuTable: mainMenuTable)
        searchForTicketsVC.modalTransitionStyle = .crossDissolve
        searchForTicketsVC.modalPresentationStyle = .pageSheet
        return searchForTicketsVC
    }
    
}

extension SearchForTicketsCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

extension SearchForTicketsCoordinator: SearchForTicketsProtocol {
    func nextFlow() {
        
    }
}
