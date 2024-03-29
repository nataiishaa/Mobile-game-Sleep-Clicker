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
    
    static var balance = 0
    
    var viewModel: MainViewModel = .init(
        characters: []
    ) {
        didSet {
            heroes.reloadData()
        }
    }
    
    private let titleLabel = UILabel()
    private let settingsButton = UIButton()
    private let shopButton = UIButton()
    private let balanceIconImageView = UIImageView()
    private let balanceLabel = UILabel()
    private let balanceStackView = UIStackView()
    private let timer = CustomClockView()
    
    private let cellId = "hero"
    private var heroes: UICollectionView!
    
    func configureUI(){
        view.addSubview(titleLabel)
        view.addSubview(settingsButton)
        view.addSubview(shopButton)
        view.addSubview(balanceLabel)
        view.addSubview(timer)
        configureTitleLable()
        configureShopButton()
        configureSettingsButton()
        configureHeroes()
        configureBalanceLabel()
        configureTimer()
    }
    
    func configureTimer(){
        timer.pinLeft(to: view.leadingAnchor, 70)
        timer.pinTop(to: titleLabel.bottomAnchor, 10)
        timer.setWidth(50)
        timer.setHeight(30)
    }
    
    
    func configureBalanceStackView() {
        // Настройка иконки баланса
        balanceIconImageView.image = UIImage(named: "balance")
        balanceIconImageView.setWidth(100)
        balanceIconImageView.setHeight(70)
        
        // Настройка лейбла баланса
        balanceLabel.text = " \(MainViewController.balance)"
        balanceLabel.textColor = .white
        
        // Настройка стека
        balanceStackView.axis = .horizontal
        balanceStackView.alignment = .center
        balanceStackView.distribution = .fillProportionally
        balanceStackView.spacing = 8 // Расстояние между элементами
        
        // Добавление элементов в стек
        balanceStackView.addArrangedSubview(balanceIconImageView)
        balanceStackView.addArrangedSubview(balanceLabel)
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(balanceStackView)
        
        // Констрейнты для стека
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            balanceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            balanceIconImageView.heightAnchor.constraint(equalToConstant: 100), // Высота иконки
            balanceIconImageView.widthAnchor.constraint(equalToConstant: 100) // Ширина иконки
        ])
    }
    
    func configureTitleLable() {
        // Настройка titleLabel
        titleLabel.text = "World of Sweet Dreams"
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
    
    func configureSettingsButton() {
        // Настройка settingsButton
        settingsButton.setImage(UIImage(named: "settingsIcon"), for: .normal)
        settingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        settingsButton.pinLeft(to: titleLabel.trailingAnchor, 30)
        settingsButton.pinCenterY(to: titleLabel.centerYAnchor)
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
        
        interactor?.activate()
        self.router = MainRouterImp(interactor: interactor!, view: self)
        
        // Запуск таймера
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(checkCharacters), userInfo: nil, repeats: true)
        
        
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
    
}

// MARK: - MainViewControllerProtocol

extension MainViewController: MainViewControllerProtocol {
    func set(interactor: MainInteractor) {
        self.interactor = interactor
    }
    
    func display(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let heroCell = heroes.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HeroCell
        if(heroCell.hero?.sleepState == .awake) {
            heroCell.heroImageView.image = heroCell.hero?.imageAwake
        } else {
            heroCell.heroImageView.image = heroCell.hero?.imageSleep
        }
        heroCell.setHero(hero: viewModel.characters[indexPath.row])
        heroCell.heroNameLabel.text = heroCell.hero?.name
        heroCell.heroHPLabel.text = heroCell.hero?.hp.formatted()
        heroCell.heroSleepinessLabel.text = heroCell.hero?.sleepiness.formatted()
        heroCell.backgroundColor = UIColor(hex: "4A40BB")
        //heroCell.backgroundColor = .white
        
        if let cell = collectionView.cellForItem(at: indexPath) as? HeroCell {
            cell.updateUI()
        }
        
        return heroCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? HeroCell else { return }
        
        let hero = cell.hero
//        if (hero!.sleepState == MainModelDTO.SleepState.asleep) {
//            hero!.stopSleeping()
//        } else {
//            hero!.startSleeping()
//        }
        interactor?.didCharacterTapped(index: indexPath.row)
        
        //cell.heroImageView.image = hero?.sleepState == .awake ? hero?.imageAwake : hero?.imageSleep
        
        cell.heroHPLabel.text = hero!.hp.formatted()
        cell.updateUI()
        MainViewController.balance += 1
        balanceLabel.text = "\(MainViewController.balance)"
    }
    
    
    func configureShopButton() {
        // Настройка shopButton
        shopButton.setImage(UIImage(named: "shopIcon"), for: .normal)
        shopButton.addTarget(self, action: #selector(goToShop), for: .touchUpInside)
        shopButton.pinLeft(to: titleLabel.trailingAnchor,-3)
        shopButton.pinCenterY(to: titleLabel.centerYAnchor)
    }
    @objc
    private func goToShop() {
        router?.goToShop()
    }
    
    @objc func checkCharacters() {
        // Перебор всех персонажей и обновление их состояния
        for (index, character) in viewModel.characters.enumerated() {
            if character.sleepState == .asleep {
                // Если персонаж спит, проверяем продолжительность сна и обновляем hp
                character.stopSleeping() // Этот метод уже обновляет hp в зависимости от времени сна
                // Принудительно обновляем UI для отображения изменений
                if let cell = heroes.cellForItem(at: IndexPath(row: index, section: 0)) as? HeroCell {
                    cell.heroHPLabel.text = character.hp.formatted()
                }
            }
        }
        balanceLabel.text = "\(MainViewController.balance)"
    }

    
}
