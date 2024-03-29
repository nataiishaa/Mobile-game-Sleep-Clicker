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
        view.addSubview(titleLabel)
        view.addSubview(balanceLabel)
        configureTitleLable()
        configureHeroes()
        configureBackButton()
        configureBalanceLabel()
        view.addSubview(settingsButton)
        configureSettingsButton()
        view.addSubview(changeShopButton)
        configureChangeShopButton()
        view.addSubview(shopNameView)
        configureShopNameView()
    }
    
    func configureSettingsButton() {
        // Настройка settingsButton
        settingsButton.setImage(UIImage(named: "settingsIcon"), for: .normal)
        settingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        settingsButton.pinLeft(to: titleLabel.trailingAnchor, 30)
        settingsButton.pinCenterY(to: titleLabel.centerYAnchor)
    }
    
    func configureTitleLable() {
        // Настройка titleLabel
        titleLabel.text = "Shop"
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 15)
        
    }
    
    func configureBalanceLabel() {
        balanceLabel.text = "\(MainViewController.balance)"
        balanceLabel.textColor = .white
        balanceLabel.pinCenterX(to: view.centerXAnchor)
        balanceLabel.pinTop(to: titleLabel.bottomAnchor, 10)
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
    }
    
    private func configureBackButton() {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back"), for: .normal)
        //backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        // Добавляем кнопку на view и отключаем autoresizing mask
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor), // Отступ сверху от safe area
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20), // Отступ справа от safe area
            backButton.widthAnchor.constraint(equalToConstant: 60), // Ширина кнопки
            backButton.heightAnchor.constraint(equalToConstant: 40) // Высота кнопки
        ])
    }
    
    private func configureChangeShopButton() {
        changeShopButton.backgroundColor = UIColor.gray
        changeShopButton.setWidth(150)
        changeShopButton.setHeight(50)
        changeShopButton.pinTop(to: titleLabel.bottomAnchor, 30)
        changeShopButton.pinRight(to: view.trailingAnchor, 15)
        changeShopButton.setTitle("characters", for: .normal)
        changeShopButton.addTarget(self, action: #selector(changeShop), for: .touchUpInside)
    }
    
    private func configureShopNameView() {
        shopNameView.text = "improve cloth"
        shopNameView.backgroundColor = UIColor.gray
        shopNameView.setWidth(150)
        shopNameView.setHeight(50)
        shopNameView.pinTop(to: titleLabel.bottomAnchor, 30)
        shopNameView.pinLeft(to: view.leadingAnchor, 15)
    }
    
    @objc
    func changeShop() {
        print("hello")
    }
    
    @objc
    func backAction() {
        
        if let navController = navigationController, navController.viewControllers.first != self {
            navController.popViewController(animated: true)
        } else {
            
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - MainViewControllerProtocol

extension ShopViewController: ShopViewControllerProtocol {
    func set(interactor: ShopInteractor) {
        self.interactor = interactor
    }
    
    func display(viewModel: ShopViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.improves.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let improveCell = boosts.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImproveCell
        improveCell.improveImageView.image = improveCell.improve?.imageBoost
        improveCell.setHero(improve: viewModel.improves[indexPath.row])
        improveCell.improveNameLabel.text = improveCell.improve?.name
        improveCell.improvePriceLabel.text = improveCell.improve?.price.formatted()
        improveCell.improveTimeLabel.text = improveCell.improve?.time.formatted()
        improveCell.backgroundColor = .white
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ImproveCell {
            cell.updateUI()
        }
        
        return improveCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImproveCell else { return }
        
        let improve = cell.improve
        if (MainViewController.balance < improve!.price) { return }
        interactor?.didCharacterTapped(index: indexPath.row)
        
        MainViewController.balance -= improve!.price
        balanceLabel.text = "\(MainViewController.balance)"
    }
    
    @objc
    private func goToSettings() {
        router?.goToSettings()
    }
}
