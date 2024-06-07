//
//  aviaTicketsViewController.swift
//  SaleAirTickets
//
//  Created by Kos on 03.06.2024.
//

import UIKit

protocol  AviaTicketsViewControllerDelegate: AnyObject {
    func nextFlow()
}

final class AviaTicketsViewController: UIViewController {

    //MARK: - Typealias
    
    typealias DataSource = UICollectionViewDiffableDataSource <Int, OffersUIModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, OffersUIModel>
    
    //MARK: - Method
    private var viewModel: AviaTicketsModelProtocol
    private lazy var dataSource = makeDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(AviaViewCell.self, forCellWithReuseIdentifier: AviaViewCell.identifier)
        return collectionView
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 2
        label.textColor = .customWhite
        label.text = "Поиск дешевых авиабилетов"
        return label
    }()
    
    private lazy var headerCollectionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .customWhite
        label.text = "Музыкально отлететь"
        return label
    }()
    
    private lazy var toTextField = CustomUITextField(placeholder: "Откуда - Москва", fontSize: 16, backgroundColor: .customGray1, icon: nil)
    
    private lazy var fromTextField: CustomUITextField = {
        let textField = CustomUITextField(placeholder: "Куда - Турция", fontSize: 16, backgroundColor: .customGray1, icon: nil)
        textField.addTarget(self, action: #selector(touchTextField), for: .allEditingEvents)
        return textField
    }()
    private lazy var searchImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.image = UIImage(named: "search")
        return image
    }()

    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .customGray2
        return separator
    }()
        
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [toTextField,fromTextField])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return stack
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchImage, vStack])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.backgroundColor = .customGray1
        stack.layer.cornerRadius = 20
        stack.layer.borderWidth = 12
        stack.layer.masksToBounds = false
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.borderColor = UIColor(named: "customGray2")?.cgColor
        return stack
    }()
    
    //MARK: - Method
    
    init(viewModel: AviaTicketsModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindingModel()
        viewModel.getOffer()
    }
    
    //MARK: - Proporties
    
    private func bindingModel() {
        viewModel.stateChanger = { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                ()
            case .done(offers: let offers):
                self.makeShapshot(offers: offers)
            case .error(error: let error):
                print(error)
            }
        }
    }
        
    private func setupView() {
        view.addSubviews(headerLabel,hStack,separator, headerCollectionLabel, collectionView,  translatesAutoresizingMaskIntoConstraints: false)
        collectionView.backgroundColor = .black
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.widthAnchor.constraint(equalToConstant: 172),
            headerLabel.heightAnchor.constraint(equalToConstant: 60),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            hStack.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 40),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.widthAnchor.constraint(equalToConstant: 328),
            hStack.heightAnchor.constraint(equalToConstant: 122),
            
  
            separator.centerYAnchor.constraint(equalTo: vStack.centerYAnchor),
            separator.widthAnchor.constraint(equalToConstant: 232),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor),
            
            headerCollectionLabel.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 20),
            headerCollectionLabel.leadingAnchor.constraint(equalTo: hStack.leadingAnchor),
            headerCollectionLabel.heightAnchor.constraint(equalToConstant: 26),
            
            collectionView.topAnchor.constraint(equalTo: headerCollectionLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
        ])
    }
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AviaViewCell.identifier, for: indexPath) as? AviaViewCell else { return UICollectionViewCell() }
            cell.configurationCellCollection(with: itemIdentifier)
            return cell
        }
    }
    
    private func makeShapshot(offers: [OffersUIModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(offers, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(153),
            heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitems: [item])
        let section  = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 20
        let lauout = UICollectionViewCompositionalLayout(section: section)
        return lauout
    }
    
    @objc private func touchTextField() {
        viewModel.nextFlow()
    }
}


