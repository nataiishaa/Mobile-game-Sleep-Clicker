//
//  BedroomViewController.swift
//
//  Created by Наталья Захарова on 13.03.2024.
//

import UIKit

final class BedroomViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
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
    
    // MARK: - Fields
    private let router: BedroomRoutingLogic
    private let interactor: BedroomBusinessLogic

    // MARK: - LifeCycle
    init(
        router: BedroomRoutingLogic,
        interactor: BedroomBusinessLogic
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //interactor.loadStart(BedroomModel.Start.Request())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.loadStart(BedroomModel.Start.Request())
    }

    private func configureUI(){
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
        view.backgroundColor = UIColor(hex: "301CB0")
        configureBalanceStackView()
        heroes.delegate = self
        heroes.dataSource = self
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
        
     
        balanceStackView.axis = .horizontal
        balanceStackView.alignment = .center
        balanceStackView.distribution = .fill
        balanceStackView.spacing = 8
        
        
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
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.loadStop(BedroomModel.Stop.Request())
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

// MARK: - BedroomDisplayLogic

extension BedroomViewController: BedroomDisplayLogic {
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        charactersViewData = viewModel.characters
        balanceLabel.text = String(viewModel.balance)
                
        boostsViewData = viewModel.boostViewData
        heroes.allowsSelection = !viewModel.isAutoClick
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension BedroomViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        interactor.loadTap(BedroomModel.Tap.Request(index: indexPath.row))
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
        router.routeToShop()
    }
}

