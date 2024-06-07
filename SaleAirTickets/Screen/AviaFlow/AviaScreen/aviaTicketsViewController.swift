//
//  aviaTicketsViewController.swift
//  SaleAirTickets
//
//  Created by Kos on 03.06.2024.
//

import UIKit

final class AviaTicketsViewController: UIViewController {

    private var viewModel:AviaTicketsModelProtocol
    
    init(viewModel: AviaTicketsModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

