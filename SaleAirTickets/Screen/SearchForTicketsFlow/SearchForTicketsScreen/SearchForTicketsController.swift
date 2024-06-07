//
//  SearchForTicketsController.swift
//  SaleAirTickets
//
//  Created by Kos on 06.06.2024.
//

import UIKit

final class SearchForTicketsController: UIViewController {
    
    
    private let mainMenu: [MenuItem]
    private let mainMenuTable: [MenuItemTable]

    
    private var viewModel: SearchForTicketsModelProtocol
    private lazy var toTextField = CustomUITextField(placeholder: "Откуда - Москва", fontSize: 16, backgroundColor: .customGray1, icon: UIImage(named: "airplanTo"))
    
    private lazy var fromTextField = CustomUITextField(placeholder: "Куда - Турция", fontSize: 16, backgroundColor: .customGray1, icon: UIImage(named: "searchFrom"))
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .customGray3
        return separator
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.register(SearchForTicketsCell.self, forCellWithReuseIdentifier: SearchForTicketsCell.identifier)
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SearchForTicketsTable.self, forCellReuseIdentifier: SearchForTicketsTable.identifier)
        return tableView
    }()
        
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [toTextField,fromTextField])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.layer.cornerRadius = 20
        stack.clipsToBounds = true
        return stack
    }()

    
    init(viewModel: SearchForTicketsModelProtocol, mainMenu: [MenuItem], mainMenuTable: [MenuItemTable]) {
        self.viewModel = viewModel
        self.mainMenu = mainMenu
        self.mainMenuTable = mainMenuTable
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
        setupCollectionView()
        setupTableView()
        bindingModel()

    }
        
    private func setupCollectionView() {
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = .black
        tableView.separatorColor = .customGray4
    }
    
    private func setupView() {
        view.addSubviews(hStack, separator,collectionView, tableView, translatesAutoresizingMaskIntoConstraints: false)
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.widthAnchor.constraint(equalToConstant: 328),
            hStack.heightAnchor.constraint(equalToConstant: 122),
            
            separator.centerYAnchor.constraint(equalTo: hStack.centerYAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: hStack.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: hStack.trailingAnchor, constant: -20),
    
            collectionView.topAnchor.constraint(equalTo: hStack.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 130),
            
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -280),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
  
        ])
    }
    
    private func bindingModel() {
        viewModel.stateChanger = { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                ()
            case .done(ticketsOffers: let ticketsOffers):
                ()
            case .error(error: let error):
                print(error)
            }
        }
    }
}


extension SearchForTicketsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainMenu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchForTicketsCell.identifier, for: indexPath) as? SearchForTicketsCell else {
            return UICollectionViewCell()
        }
        cell.configurationCellCollectionеTicktes(with: mainMenu[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchForTicketsController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        
        let itemsInRow: CGFloat = 4
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: 20)
        return CGSize(width: width, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is SearchForTicketsCell {
            if indexPath.item == 0 {
                dismiss(animated: true)
            }
            if indexPath.item == 1 {
                print(2)
            }
            if indexPath.item == 2 {
                dismiss(animated: true)
            }
            if indexPath.item == 3 {
                dismiss(animated: true)
            }
        }
    }
}

extension SearchForTicketsController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenuTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchForTicketsTable.identifier, for: indexPath) as? SearchForTicketsTable else { return UITableViewCell() }
        cell.configurationCellTable(with: mainMenuTable[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(2)
    }
    
  
}
