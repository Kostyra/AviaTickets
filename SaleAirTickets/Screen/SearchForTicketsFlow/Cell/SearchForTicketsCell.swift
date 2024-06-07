//
//  SearchForTicketsView.swift
//  SaleAirTickets
//
//  Created by Kos on 07.06.2024.
//

import UIKit

final class SearchForTicketsCell: UICollectionViewCell {
    
    //MARK: - Method
    
    private lazy var imageBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 14, weight: .regular)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        textLabel.backgroundColor = .customBlack
        return textLabel
    }()

    //MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Properties
    
    private func setupView() {
        contentView.addSubviews(imageBackgroundView, imageView,textLabel, translatesAutoresizingMaskIntoConstraints: false )
        NSLayoutConstraint.activate([
            
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 48),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 48),
            imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            
            textLabel.topAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    func configurationCellCollectionеTicktes(with menuItem: MenuItem) {
        imageView.image = UIImage(named: menuItem.imageName)
        textLabel.text = menuItem.text
        imageBackgroundView.backgroundColor = menuItem.backgroundColor
    }
}


