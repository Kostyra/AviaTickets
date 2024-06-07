//
//  SearchForTicketsTable.swift
//  SaleAirTickets
//
//  Created by Kos on 07.06.2024.
//

import UIKit

final class SearchForTicketsTable: UITableViewCell {
    
    
    private lazy var imageTable: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var textCityTable: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 16, weight: .regular)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    private lazy var textTable: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 14, weight: .regular)
        textLabel.textColor = .customGray4
        textLabel.textAlignment = .center
        return textLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        backgroundColor = .customGray1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews(imageTable,textCityTable,textTable, translatesAutoresizingMaskIntoConstraints: false)
        NSLayoutConstraint.activate([
            imageTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            imageTable.heightAnchor.constraint(equalToConstant: 40),
            imageTable.widthAnchor.constraint(equalToConstant: 40),
            imageTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            textCityTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            textCityTable.leadingAnchor.constraint(equalTo: imageTable.trailingAnchor, constant: 10),
            
            textTable.topAnchor.constraint(equalTo: textCityTable.bottomAnchor, constant: 0),
            textTable.leadingAnchor.constraint(equalTo: imageTable.trailingAnchor, constant: 10),
            
        ])
    }
    
    func configurationCellTable(with popular: MenuItemTable) {
        self.imageTable.image = UIImage(named: popular.imageName)
        self.textCityTable.text = popular.textCity
        self.textTable.text = popular.text
    }
}
