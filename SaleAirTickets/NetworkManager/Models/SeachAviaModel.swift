//
//  SeachAviaModel.swift
//  SaleAirTickets
//
//  Created by Kos on 06.06.2024.
//

import Foundation


struct SeachAviaModel: Codable {
    let tickets_offers: [TicketsOffersModel]
}

struct TicketsOffersModel: Codable {
    let id: Int
    let title: Int
    let time_range: [String]
    let price: PriceTicketsModel
}

struct PriceTicketsModel: Codable {
    let value: Int
}

