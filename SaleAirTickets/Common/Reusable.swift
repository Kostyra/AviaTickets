//
//  Reusable.swift
//  SaleAirTickets
//
//  Created by Kos on 05.06.2024.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol ReusableHeaderView: AnyObject {
    static var identifierHeader: String { get }
}

extension UICollectionReusableView: ReusableHeaderView {
    @objc static var identifierHeader: String {
        return String(describing: self)
    }
}


extension UITableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol ReusableHeaderFooterView: AnyObject {
    static var identifierHeader: String { get }
}

extension UITableViewHeaderFooterView: ReusableHeaderFooterView {
    @objc static var identifierHeader: String {
        return String(describing: self)
    }
}
