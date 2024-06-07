//
//  AviaViewCell.swift
//  SaleAirTickets
//
//  Created by Kos on 05.06.2024.
//

import UIKit

final class AviaViewCell: UICollectionViewCell {
    
    //MARK: - Method
    
    private lazy var imagePeople: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var imageAriaPlan: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.image = UIImage(named: "airplan")
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var townLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var toLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "От"
        return label
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.cornerRadius = 20
        layer.masksToBounds = true
        backgroundColor = .black
        setupCollectionCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    
    private func setupCollectionCell() {
        contentView.addSubviews(imagePeople,titleLabel,townLabel,priceLabel,toLabel,imageAriaPlan,
                                translatesAutoresizingMaskIntoConstraints: false)
        
        NSLayoutConstraint.activate([
            imagePeople.heightAnchor.constraint(equalToConstant: 133),
            imagePeople.widthAnchor.constraint(equalToConstant: 133),
            imagePeople.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 19),
            titleLabel.widthAnchor.constraint(equalToConstant: 133),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: imagePeople.bottomAnchor, constant: 2),
            
            townLabel.heightAnchor.constraint(equalToConstant: 19),
            townLabel.widthAnchor.constraint(equalToConstant: 133),
            townLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            townLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            
            imageAriaPlan.heightAnchor.constraint(equalToConstant: 25),
            imageAriaPlan.widthAnchor.constraint(equalToConstant: 25),
            imageAriaPlan.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            imageAriaPlan.topAnchor.constraint(equalTo: townLabel.bottomAnchor, constant: 2),
            
            toLabel.heightAnchor.constraint(equalToConstant: 19),
            toLabel.leadingAnchor.constraint(equalTo: imageAriaPlan.trailingAnchor, constant: 2),
            toLabel.topAnchor.constraint(equalTo: townLabel.bottomAnchor, constant: 5),
            
            priceLabel.heightAnchor.constraint(equalToConstant: 19),
            priceLabel.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor, constant: 2),
            priceLabel.topAnchor.constraint(equalTo: townLabel.bottomAnchor, constant: 5),
        ])
    }
    
    func configurationCellCollection(with offer: OffersUIModel) {
        self.imagePeople.image = UIImage(named: String(offer.id))
        self.titleLabel.text = offer.title
        self.townLabel.text = offer.town
        self.priceLabel.text = String(offer.price.value)
    }
}
