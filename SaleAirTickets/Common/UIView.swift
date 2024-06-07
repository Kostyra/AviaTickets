//
//  UIView.swift
//  SaleAirTickets
//
//  Created by Kos on 03.06.2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView..., translatesAutoresizingMaskIntoConstraints: Bool = false) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
            self.addSubview($0)
        }
    }
}
