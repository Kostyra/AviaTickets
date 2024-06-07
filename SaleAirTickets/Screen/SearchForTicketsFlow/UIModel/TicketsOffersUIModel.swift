//
//  TicketsOffersUIModel.swift
//  SaleAirTickets
//
//  Created by Kos on 06.06.2024.
//

import UIKit



struct TicketsOffersUIModel: Hashable {
    let id: Int
    let title: Int
    let timeRange: [String]
    let price: PriceTicketsUIModel
    init(id: Int, title: Int, timeRange: [String], price: PriceTicketsUIModel) {
        self.id = id
        self.title = title
        self.timeRange = timeRange
        self.price = price
    }
}

extension TicketsOffersUIModel {
    init(offersTikets: TicketsOffersModel) {
        self.id = offersTikets.id
        self.title = offersTikets.title
        self.timeRange = offersTikets.time_range
        self.price = PriceTicketsUIModel(value: offersTikets.price)
    }
}

struct PriceTicketsUIModel: Hashable {
    let value: Int
    init(value: Int) {
        self.value = value
    }
}

extension PriceTicketsUIModel {
    init(value: PriceTicketsModel) {
        self.value = value.value
    }
}
