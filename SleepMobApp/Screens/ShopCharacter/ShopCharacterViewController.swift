//
//   ShopViewController.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//

import UIKit

final class ShopCharacterViewController: UIViewController {
    private var interactor: ShopCharacterInteractor?
    private var router: ShopCharacterRouter?
    
    var viewModel: ShopCharacterViewModel = .init(
        heroes: []
    ) {
        didSet {
            heroes.reloadData()
        }
    }
    
    private let titleLabel = UILabel()
    private let balanceIconImageView = UIImageView()
    private let settingsButton = UIButton()
    private let balanceStackView = UIStackView()
    private let balanceLabel = UILabel()
    private let changeShopButton = UIButton()
    private let shopNameView = UILabel()
    private let backButton = UIButton()
    
    private let cellId = "improve"
    private var heroes: UICollectionView!
    
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
        view.addSubview(backButton)
        configureBackButton()
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
        heroes.delegate = self
        heroes.dataSource = self
        
        interactor?.activate()
        self.router = ShopCharacterRouterImp(interactor: interactor!, view: self)
        
    }
    
    private func configureHeroes() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 45
        layout.sectionInset = UIEdgeInsets(top: 45, left: 22, bottom: 25, right: 22)
        layout.itemSize = CGSize(width: (view.frame.width-60)/2, height: view.frame.height/4)
        let rect = CGRect(x: 0, y: 190, width: view.frame.width, height: view.frame.height - 285)
        heroes = UICollectionView(frame: rect, collectionViewLayout: layout)
        heroes.dataSource = self
        heroes.delegate = self
        heroes.register(HeroCell.self, forCellWithReuseIdentifier: cellId)
        heroes.showsVerticalScrollIndicator = true
        heroes.backgroundColor = .clear
        heroes.layer.masksToBounds = true
        view.addSubview(heroes)
    }
    private func configureBackButton() {
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(goToMain), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureChangeShopButton() {
        changeShopButton.setTitle("improve cloth", for: .normal)
        changeShopButton.backgroundColor = UIColor.gray
        changeShopButton.setWidth(150)
        changeShopButton.setHeight(50)
        changeShopButton.pinTop(to: titleLabel.bottomAnchor, 30)
        changeShopButton.pinLeft(to: view.leadingAnchor, 15)
        changeShopButton.addTarget(self, action: #selector(goToShopBoosts), for: .touchUpInside)
        
    }
    
    private func configureShopNameView() {
        
        shopNameView.backgroundColor = UIColor.gray
        shopNameView.setWidth(150)
        shopNameView.setHeight(50)
        shopNameView.pinTop(to: titleLabel.bottomAnchor, 30)
        shopNameView.pinRight(to: view.trailingAnchor, 15)
        shopNameView.text = "character"
        
        
        
    }
    
    
    
}

// MARK: - MainViewControllerProtocol

extension ShopCharacterViewController: ShopCharacterViewControllerProtocol {
    func set(interactor: ShopCharacterInteractor) {
        self.interactor = interactor
    }
    
    func display(viewModel: ShopCharacterViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ShopCharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let improveCell = heroes.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HeroCell
        improveCell.heroImageView.image = improveCell.hero?.imageAwake
        improveCell.setHero(hero: viewModel.heroes[indexPath.row])
        improveCell.heroNameLabel.text = improveCell.hero?.name
        improveCell.heroHPLabel.text = improveCell.hero?.price.formatted()
        improveCell.backgroundColor = .white
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ImproveCell {
            cell.updateUI()
        }
        
        return improveCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? HeroCell else { return }
        
        let hero = cell.hero
        if (MainViewController.balance < hero!.price) { return }
        interactor?.didCharacterTapped(index: indexPath.row)
        
        MainViewController.balance -= hero!.price
        balanceLabel.text = "\(MainViewController.balance)"
    }
    
    @objc
    private func goToSettings() {
        router?.goToSettings()
    }
    @objc
    private func goToShopBoosts() {
        router?.goToShopBoosts()
    }
    @objc
    private func goToMain() {
        router?.goToMain()
    }
    
    
    
}

