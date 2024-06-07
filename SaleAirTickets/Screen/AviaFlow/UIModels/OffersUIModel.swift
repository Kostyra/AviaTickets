//
//  UIModel.swift
//  SaleAirTickets
//
//  Created by Kos on 03.06.2024.
//

import UIKit


struct OffersUIModel: Hashable {
    let id: Int
    let title: String
    let town: String
    let price: PriceUIModel
    init(id: Int, title: String, town: String, price: PriceUIModel) {
        self.id = id
        self.title = title
        self.town = town
        self.price = price
    }
}


extension OffersUIModel {
    init(offers: OffersModel) {
        self.id = offers.id
        self.title = offers.title
        self.town = offers.town
        self.price = PriceUIModel(value: offers.price)
    }
}

struct PriceUIModel: Hashable {
    let value: Int
    init(value: Int) {
        self.value = value
    }
}

extension PriceUIModel {
    init(value: PriceModel) {
        self.value = value.value
    }
}
