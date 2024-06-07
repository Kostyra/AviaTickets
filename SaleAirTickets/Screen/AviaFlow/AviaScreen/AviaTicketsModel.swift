//
//  AviaTicketsModel.swift
//  SaleAirTickets
//
//  Created by Kos on 03.06.2024.
//

import Foundation

protocol AviaTicketsModelProtocol {
    var stateChanger: ((AviaTicketsModel.State) -> Void)? { get set }
    func nextFlow()
    func getOffer()
}

final class AviaTicketsModel {
    
    enum State {
        case loading
        case done(offers: [OffersUIModel])
        case error(error: String)
    }
    
    private let apiService: OffersApiService
    private var offers: [OffersUIModel] = []
    private weak var coordinator: AviaTicketsCoordinator?
    
    var stateChanger: ((State) -> Void)?
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    init(coordinator: AviaTicketsCoordinator?, apiService: OffersApiService) {
        self.coordinator = coordinator
        self.apiService = apiService
    }
    deinit {
        print("AviaTicketsModel \(#function)")
    }
    
    private func getOffers() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let offers = try await apiService.getOffers()
                self.offers = offers
                self.state = .done(offers: offers)
            } catch {
                self.state = .error(error: error.localizedDescription)
            }
        }
    }
}

extension AviaTicketsModel: AviaTicketsModelProtocol {
    func getOffer() {
        getOffers()
    }
    
    func nextFlow() {
        coordinator?.nextFlow()
    }
}
