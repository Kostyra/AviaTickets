//
//  AviaModel.swift
//  SaleAirTickets
//
//  Created by Kos on 04.06.2024.
//

import Foundation

struct AviaModel: Codable {
    let offers: [OffersModel]
}

struct OffersModel: Codable {
    let id: Int
    let title: String
    let town: String
    let price: PriceModel
}

struct PriceModel: Codable {
    let value: Int
}
