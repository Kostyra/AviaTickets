//
//  SearchForTicketsModel.swift
//  SaleAirTickets
//
//  Created by Kos on 06.06.2024.
//

import Foundation

protocol SearchForTicketsModelProtocol {
    var stateChanger: ((SearchForTicketsModel.State) -> Void)? { get set }
    func nextFlow()
    func getTicketsOffer()
}


final class SearchForTicketsModel {
    
    enum State {
        case loading
        case done(ticketsOffers: [TicketsOffersUIModel])
        case error(error: String)
    }
    
    private let apiService: TicktesOfferApiService
    private var ticketsOffers: [TicketsOffersUIModel] = []
    private weak var coordinator: SearchForTicketsCoordinator?
    
    var stateChanger: ((State) -> Void)?
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    init(apiService: TicktesOfferApiService, coordinator: SearchForTicketsCoordinator?){
        self.apiService = apiService
        self.coordinator = coordinator
    }
    
    deinit {
        print("SearchForTicketsModel \(#function)")
    }
    
    private func getTicketsOffers() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let ticketsOffers = try await apiService.getTicketsOffers()
                self.ticketsOffers = ticketsOffers
                self.state = .done(ticketsOffers: ticketsOffers)
            } catch {
                self.state = .error(error: error.localizedDescription)
            }
        }
    }
}

extension SearchForTicketsModel: SearchForTicketsModelProtocol {
    func nextFlow() {
        
    }
    func getTicketsOffer() {
        getTicketsOffers()
    }
    
}
