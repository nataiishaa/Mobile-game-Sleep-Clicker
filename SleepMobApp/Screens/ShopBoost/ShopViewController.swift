//
//   ShopViewController.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//

import UIKit

final class ShopViewController: UIViewController {
    private var interactor: ShopInteractor?
    private var router: ShopRouter?
    
    var viewModel: ShopViewModel = .init(
        improves: []
    ) {
        didSet {
            boosts.reloadData()
        }
    }
    
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let balanceIconImageView = UIImageView()
    private let settingsButton = UIButton()
    private let balanceStackView = UIStackView()
    private let balanceLabel = UILabel()
    private let changeShopButton = UIButton()
    private let shopNameView = UILabel()
    
    private let cellId = "improve"
    private var boosts: UICollectionView!
    
    func configureUI(){
        configureHeroes()
        view.addSubview(titleLabel)
        view.addSubview(changeShopButton)
        view.addSubview(shopNameView)
        view.addSubview(balanceStackView)
        view.addSubview(settingsButton)
        configureBalanceStackView()
        configureTitleLable()
        configureBackButton()
        configureBalanceLabel()
        configureSettingsButton()
        configureChangeShopButton()
        configureShopNameView()
    }
    
    func configureBalanceStackView() {
        // Настройка иконки баланса
        balanceIconImageView.image = UIImage(named: "balance")
        
        // Настройка стека
        balanceStackView.axis = .horizontal
        balanceStackView.alignment = .center
        balanceStackView.distribution = .fill
        balanceStackView.spacing = 8 // Расстояние между элементами
        
        // Добавление элементов в стек
        balanceStackView.addArrangedSubview(balanceIconImageView)
        balanceStackView.addArrangedSubview(balanceLabel)
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Констрейнты для стека
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            balanceStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            balanceIconImageView.heightAnchor.constraint(equalToConstant: 37), // Высота иконки
            balanceIconImageView.widthAnchor.constraint(equalToConstant: 47), // Ширина иконки
        ])
    }
    
    func configureTitleLable() {
        // Настройка titleLabel
        let colorOne = #colorLiteral(red: 0.8433896899, green: 0.7258818746, blue: 0.7231372595, alpha: 1)
        let colorTwo = #colorLiteral(red: 1, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        
        titleLabel.attributedText = NSAttributedString(string: "Shop", attributes: [.strokeColor: colorTwo,
                                                                                       .foregroundColor: colorOne,
                                                                                       .strokeWidth: -3,
                                                                                       .font: UIFont.comicoro(size: 80)])
        titleLabel.textAlignment = .center
        titleLabel.layer.shadowRadius = 2
        titleLabel.layer.shadowOffset = .init(width: 0, height: 4)
        titleLabel.layer.shadowOpacity = 0.25
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: balanceStackView.bottomAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureBalanceLabel() {
        balanceLabel.text = "0"
        balanceLabel.font = .comicoro(size: 30)
        balanceLabel.textColor = .white
    }
    
    func configureSettingsButton() {
        // Настройка settingsButton
        settingsButton.setImage(UIImage(named: "settingsIcon"), for: .normal)
        settingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsButton.trailingAnchor.constraint(equalTo: backButton.leadingAnchor),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            settingsButton.widthAnchor.constraint(equalToConstant: 49),
            settingsButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = UIColor(hex: "0D4496")
        boosts.delegate = self
        boosts.dataSource = self
        
        interactor?.activate()
        self.router = ShopRouterImp(interactor: interactor!, view: self)
        
    }
    
    private func configureHeroes() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 45
        layout.sectionInset = UIEdgeInsets(top: 45, left: 22, bottom: 25, right: 22)
        layout.itemSize = CGSize(width: (view.frame.width-60)/2, height: view.frame.height/4)
        let rect = CGRect(x: 0, y: 190, width: view.frame.width, height: view.frame.height - 285)
        boosts = UICollectionView(frame: rect, collectionViewLayout: layout)
        boosts.dataSource = self
        boosts.delegate = self
        boosts.register(ImproveCell.self, forCellWithReuseIdentifier: cellId)
        boosts.showsVerticalScrollIndicator = true
        boosts.backgroundColor = .clear
        boosts.layer.masksToBounds = true
        view.addSubview(boosts)
        
        boosts.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            boosts.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            boosts.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            boosts.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureBackButton() {
        backButton.setImage(UIImage(named: "back"), for: .normal)
        //backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        // Добавляем кнопку на view и отключаем autoresizing mask
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25), // Отступ сверху от safe area
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0), // Отступ справа от safe area
            backButton.widthAnchor.constraint(equalToConstant: 89), // Ширина кнопки
            backButton.heightAnchor.constraint(equalToConstant: 38) // Высота кнопки
        ])
    }
    
    private func configureChangeShopButton() {
        changeShopButton.backgroundColor = UIColor.gray
        let width = view.bounds.width / 2 - 12
        changeShopButton.setWidth(width)
        changeShopButton.setHeight(67)
        changeShopButton.pinTop(to: titleLabel.bottomAnchor, 30)
        changeShopButton.pinRight(to: view.trailingAnchor, 8)
        changeShopButton.setTitle("characters", for: .normal)
        changeShopButton.addTarget(self, action: #selector(goToСharacterShop), for: .touchUpInside)
        changeShopButton.titleLabel?.font = .comicoro(size: 30)
        
        NSLayoutConstraint.activate([
            changeShopButton.bottomAnchor.constraint(equalTo: boosts.topAnchor, constant: -8)
        ])
    }
    
    private func configureShopNameView() {
        shopNameView.text = "improve cloth"
        shopNameView.font = .comicoro(size: 30)
        shopNameView.textAlignment = .center
        shopNameView.backgroundColor = UIColor.gray
        let width = view.bounds.width / 2 - 12
        shopNameView.setWidth(width)
        shopNameView.setHeight(67)
        shopNameView.pinTop(to: titleLabel.bottomAnchor, 30)
        shopNameView.pinLeft(to: view.leadingAnchor, 8)
    }
    
    @objc
    func backAction() {
        
        if let navController = navigationController, navController.viewControllers.first != self {
            navController.popViewController(animated: true)
        } else {
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    private func goToСharacterShop() {
        router?.goToCharacterShop()
    }
}

// MARK: - MainViewControllerProtocol

extension ShopViewController: ShopViewControllerProtocol {
    func set(interactor: ShopInteractor) {
        self.interactor = interactor
    }
    
    func display(viewModel: ShopViewModel, balance: Int) {
        self.viewModel = viewModel
        balanceLabel.text = String(balance)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.improves.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let boost = viewModel.improves[indexPath.row]
        
        let improveCell = boosts.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImproveCell
        improveCell.improveImageView.image = boost.imageBoost
        improveCell.improveNameLabel.text = boost.name
        improveCell.improvePriceLabel.text = boost.price.formatted()
        improveCell.improveDescriptionLabel.text = boost.descriptionBoost
        
        return improveCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didCharacterTapped(index: indexPath.row)
    }
    
    @objc
    private func goToSettings() {
        router?.goToSettings()
    }
    
    
}
