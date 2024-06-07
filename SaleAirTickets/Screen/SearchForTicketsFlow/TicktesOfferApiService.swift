//
//  TicktesOfferApiService.swift
//  SaleAirTickets
//
//  Created by Kos on 06.06.2024.
//

import Foundation

import Foundation


protocol TicktesOfferApiServiceProtocol {
    func getTicketsOffers() async throws -> [TicketsOffersUIModel]
}


final class TicktesOfferApiService {
    private let mapper: CoreMapperProtocol
    private let networkManager: CoreNetworkManager
    
    init(mapper: CoreMapperProtocol, networkManager: CoreNetworkManager) {
        self.mapper = mapper
        self.networkManager = networkManager
    }
}


extension TicktesOfferApiService: TicktesOfferApiServiceProtocol {
    func getTicketsOffers() async throws -> [TicketsOffersUIModel] {
        let data = try await networkManager.getRequest(enterPoint: .offers)
        let tickets = try await mapper.map(from: data, jsonType: SeachAviaModel.self)
        return tickets.tickets_offers.map { TicketsOffersUIModel(offersTikets: $0) }
    }
}
