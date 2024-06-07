//
//  EnterPoint.swift
//  SaleAirTickets
//
//  Created by Kos on 04.06.2024.
//

import Foundation


enum EnterPoint {
    case offers
    case ticketsOffers
    case tickets
    var urlRequest: URLRequest {
        switch self {
        case .offers:
            return URLRequest(url: URL(string: "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd")!)
        case .ticketsOffers:
            return URLRequest(url: URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017")!)
        case .tickets:
            return URLRequest(url: URL(string: "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf")!)
        }
    }
}
