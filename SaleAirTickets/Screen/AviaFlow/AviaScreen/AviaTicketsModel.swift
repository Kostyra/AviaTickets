//
//  AviaTicketsModel.swift
//  SaleAirTickets
//
//  Created by Kos on 03.06.2024.
//

import Foundation

protocol AviaTicketsModelProtocol {
    var stateChanger: ((AviaTicketsModel.State) -> Void)? { get set }
    func nextFlow()
}

final class AviaTicketsModel {
    
    enum State {
        case loading
        case show1
        case show2
        case show3
        case error(error: String)
    }
    
    private weak var coordinator: AviaTicketsCoordinator?
    var stateChanger: ((State) -> Void)?
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    init(coordinator: AviaTicketsCoordinator?) {
        self.coordinator = coordinator
    }
    deinit {
        print("AviaTicketsModel \(#function)")
    }
    
}


extension AviaTicketsModel: AviaTicketsModelProtocol {
    func nextFlow() {
        
    }
    
    
}
