//
//  OffersApiService.swift
//  SaleAirTickets
//
//  Created by Kos on 04.06.2024.
//

import Foundation


protocol OffersApiServiceProtocol {
    func getOffers() async throws -> [OffersUIModel]
}

final class OffersApiService {
    
    //MARK: - Method
    
    private let mapper: CoreMapperProtocol
    private let networkManager: CoreNetworkManager
    
    //MARK: - Life Cycle
    
    init(mapper: CoreMapperProtocol, networkManager: CoreNetworkManager) {
        self.mapper = mapper
        self.networkManager = networkManager
    }
}

//MARK: - extension OffersApiServiceProtocol

extension OffersApiService: OffersApiServiceProtocol {
    func getOffers() async throws -> [OffersUIModel] {
        let data = try await networkManager.getRequest(enterPoint: .offers)
        let avia = try await mapper.map(from: data, jsonType: AviaModel.self)
        return avia.offers.map { OffersUIModel(offers: $0) }
    }
}
