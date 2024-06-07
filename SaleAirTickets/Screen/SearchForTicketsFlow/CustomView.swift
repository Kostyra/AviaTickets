//
//  CustomView.swift
//  SaleAirTickets
//
//  Created by Kos on 07.06.2024.
//

import UIKit

final class CustomView: UIView {
    private lazy var CustomView: UIView = {
        let view = UIView()
        view.backgroundColor = .customGray1
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return  view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        addSubviews(CustomView, translatesAutoresizingMaskIntoConstraints: false)
        NSLayoutConstraint.activate([
            CustomView.centerXAnchor.constraint(equalTo: centerXAnchor),
            CustomView.centerYAnchor.constraint(equalTo: centerYAnchor),
            CustomView.widthAnchor.constraint(equalToConstant: 38),
            CustomView.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    


}
