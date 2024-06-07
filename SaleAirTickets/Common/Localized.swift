//
//  Localized.swift
//  SaleAirTickets
//
//  Created by Kos on 03.06.2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "-")
    }
}

