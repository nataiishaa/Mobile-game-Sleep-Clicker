//
//  MainViewController.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 13.03.2024.
//

import UIKit

final class MainViewController: UIViewController {
    private var interactor: MainInteractor?
    private var router: MainRouter?
    
    var charactersViewData = [CharacterViewData]() {
        didSet {
            heroes.reloadData()
        }
    }
    
    var boostsViewData = [BoostViewData]() {
        didSet {
            boostCollectionView.reloadData()
        }
    }
    
    private let titleLabel = UILabel()
    private let settingsButton = UIButton()
    private let shopButton = UIButton()
    private let balanceIconImageView = UIImageView()
    private let balanceLabel = UILabel()
    private let balanceStackView = UIStackView()
    private let timer = CustomClockView()
    private var boostCollectionView: UICollectionView!
    
    private let cellId = "hero"
    private var heroes: UICollectionView!
    
    func configureUI(){
        view.addSubview(titleLabel)
        view.addSubview(settingsButton)
        view.addSubview(shopButton)
        view.addSubview(balanceLabel)
        view.addSubview(timer)
        view.addSubview(balanceStackView)
        configureTitleLable()
        configureBoostCollectionView()
        configureShopButton()
        configureSettingsButton()
        configureHeroes()
        configureBalanceLabel()
        configureTimer()
    }
    
    func configureBoostCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = .init(width: 70, height: 50)
        boostCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        boostCollectionView.dataSource = self
        boostCollectionView.register(BoostCollectionViewCell.self, forCellWithReuseIdentifier: "BoostCollectionViewCell")
        boostCollectionView.backgroundColor = .clear
        boostCollectionView.layer.masksToBounds = true
        view.addSubview(boostCollectionView)
        boostCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            boostCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            boostCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            boostCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            boostCollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureTimer(){
        timer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 21),
            timer.topAnchor.constraint(equalTo: boostCollectionView.bottomAnchor, constant: 10),
            timer.heightAnchor.constraint(equalToConstant: 25)
        ])
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
        
        titleLabel.attributedText = NSAttributedString(string: "World of sweet dreams 🌙", attributes: [.strokeColor: colorTwo,
                                                                                       .foregroundColor: colorOne,
                                                                                       .strokeWidth: -3,
                                                                                       .font: UIFont.comicoro(size: 30)])
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
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
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
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            settingsButton.widthAnchor.constraint(equalToConstant: 49),
            settingsButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    @objc
    private func goToSettings() {
        if let navigationController = self.navigationController {
            // Создаем экземпляр SettingsViewController
            let settingsVC = SettingsViewController()
            
            navigationController.pushViewController(settingsVC, animated: true)
        } else {
            
            let settingsVC = SettingsViewController()
            
            settingsVC.modalPresentationStyle = .fullScreen
            self.present(settingsVC, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = UIColor(hex: "0D4496")
        configureBalanceStackView()
        heroes.delegate = self
        heroes.dataSource = self
        self.router = MainRouterImp(interactor: interactor!, view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.showCharacters()
        interactor?.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor?.stopTimer()
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
        heroes.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heroes.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            heroes.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            heroes.topAnchor.constraint(equalTo: timer.bottomAnchor),
            heroes.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

// MARK: - MainViewControllerProtocol

extension MainViewController: MainViewControllerProtocol {
    func set(interactor: MainInteractor) {
        self.interactor = interactor
    }
    
    func display(viewModel: [CharacterViewData], balance: Int) {
        charactersViewData = viewModel
        balanceLabel.text = String(balance)
    }
    
    func display(boostViewData: [BoostViewData], autoClick: Bool) {
        boostsViewData = boostViewData
        heroes.allowsSelection = !autoClick
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == heroes {
            return charactersViewData.count
        } else if collectionView == boostCollectionView {
            return boostsViewData.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == heroes {
            let hero = charactersViewData[indexPath.row]
            let cell = heroes.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HeroCell
            cell.configure(hero: hero)
            return cell
        } else if collectionView == boostCollectionView {
            let boost = boostsViewData[indexPath.row]
            let cell = boostCollectionView.dequeueReusableCell(withReuseIdentifier: "BoostCollectionViewCell", for: indexPath) as! BoostCollectionViewCell
            cell.boostImageView.image = boost.imageBoost
            cell.timerLabel.text = boost.timer
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didCharacterTapped(index: indexPath.row)
    }
    
    func configureShopButton() {
        // Настройка shopButton
        shopButton.setImage(UIImage(named: "shopIcon"), for: .normal)
        shopButton.addTarget(self, action: #selector(goToShop), for: .touchUpInside)
        shopButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shopButton.widthAnchor.constraint(equalToConstant: 54),
            shopButton.heightAnchor.constraint(equalToConstant: 56),
            shopButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            shopButton.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: 3)
        ])
    }
    @objc
    private func goToShop() {
        router?.goToShop()
    }
}
