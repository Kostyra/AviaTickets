//
//  MenuItem.swift
//  SaleAirTickets
//
//  Created by Kos on 07.06.2024.
//

import UIKit

import Foundation

struct MenuItem {
    var imageName: String
    var text: String
    let backgroundColor: UIColor
}

extension MenuItem {
    public static func make() -> [Self] {
        [
            MenuItem(imageName: "difficultRoute", text: "Сложный маршрут", backgroundColor: .customGreen),
            MenuItem(imageName: "Where", text: "Куда угодно", backgroundColor: .customBlue),
            MenuItem(imageName: "weekend", text: "Выходные", backgroundColor: .customDarkBlue),
            MenuItem(imageName: "Image", text: "Горячие выходные", backgroundColor: .customRed)
        ]
    }
}

struct MenuItemTable {
    var imageName: String
    var textCity: String
    var text: String
}

extension MenuItemTable {
    public static func make() -> [Self] {
        [
            MenuItemTable(imageName: "image", textCity: "Стамбул", text: "Популярное направление"),
            MenuItemTable(imageName: "image1", textCity: "Сочи", text: "Популярное направление"),
            MenuItemTable(imageName: "image2", textCity: "Пхукет", text: "Популярное направление"),
        ]
    }
}
