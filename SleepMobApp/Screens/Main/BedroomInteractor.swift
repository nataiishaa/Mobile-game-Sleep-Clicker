//
//  MainInteractor.swift
//  SleepMobApp
//

import Foundation

final class BedroomInteractor: BedroomBusinessLogic {
    // MARK: - Fields
    private var model: MainModelDTO = MainModelDTO()
    private let worker: BedroomWorkingLogic
    private let presenter: BedroomPresentationLogic
    private var timer: Timer?
    private var autoClick = false
    private var priceMultiplier: Int = 1
    private var boostTimer: Timer?
    
    // MARK: - Lifecycle
    init(
        presenter: BedroomPresentationLogic,
        worker: BedroomWorkingLogic = BedroomWorker()
    ) {
        self.worker = worker
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        loadCharacters()
        startTimer()
        presenter.presentStart(
            Model.Start.Response(
                balance: UserData.balance,
                boosts: model.boosts,
                characters: model.items
            )
        )
    }
    
    func loadTap(_ request: Model.Tap.Request) {
        didTapCharacter(index: request.index)
    }
    
    func loadStop(_ request: Model.Stop.Request) {
        timer?.invalidate()
        boostTimer?.invalidate()
    }
    
    // MARK: - Private methods
    private func loadCharacters() {
        model.items = worker.getCharacters()
        model.boosts = worker.getBoosts(type: nil)
        applyBoost()
    }
    
    private func applyBoost() {
        priceMultiplier = model.boosts.compactMap({ $0.boostType.priceMultiplier }).max() ?? 1
        autoClick = model.boosts.contains(where: { $0.boostType == .fairy })
        
        if let index = model.boosts.firstIndex(where: { $0.boostType == .mask }) {
            model.items.forEach({
                $0.hp = 100
            })
            let boost = model.boosts.remove(at: index)
            worker.delete(boost)
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self else { return }
            
            var dead = [Int]()
            
            for (index, hero) in model.items.enumerated() {
                performAutoClickAction(index: index)
                
                switch hero.characterState {
                case .asleep:
                    asleepHero(index: index)
                case .awake:
                    awakeHero(index: index)
                }
                
                if hero.lives <= 0 {
                    dead.append(index)
                }
            }
            
            removeCharacters(indexes: dead)
            presentUpdate()
        }
        
        boostTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            
            var boostEndedIndex = [Int]()
            
            for (index, boost) in model.boosts.enumerated() {
                boost.timer -= 1
                
                if boost.timer <= 0 {
                    boostEndedIndex.append(index)
                }
            }
            
            removeBoostEnded(indexes: boostEndedIndex)
            applyBoost()
        })
    }
    
    private func performAutoClickAction(index: Int) {
        let hero = model.items[index]
        
        if autoClick {
            if (hero.sleepiness <= 20 && hero.characterState == .awake) ||
                (hero.sleepiness >= 80 && hero.characterState == .asleep) {
                didTapCharacter(index: index)
            }
        }
    }
    
    private func didTapCharacter(index: Int) {
        let hero = model.items[index]
        
        if (hero.sleepiness >= 0 && hero.sleepiness <= 20) ||
            (hero.sleepiness >= 80 && hero.sleepiness <= 100 ) {
            UserData.balance += (1 * priceMultiplier)
        }
        
        hero.characterState = hero.characterState.next
        
        worker.save()
        presentUpdate()
    }
    
    private func presentUpdate() {
        presenter.presentStart(
            Model.Start.Response(
                balance: UserData.balance,
                boosts: model.boosts,
                characters: model.items
            )
        )
    }
    
    private func asleepHero(index: Int) {
        let hero = model.items[index]
        
        if hero.sleepiness > 100 {
            damage(index: index)
        } else {
            hero.sleepiness += 1
        }
    }
    
    private func awakeHero(index: Int) {
        let hero = model.items[index]
        
        if hero.sleepiness < 0 {
            damage(index: index)
        } else {
            hero.sleepiness -= 1
        }
    }
    
    private func damage(index: Int) {
        let hero = model.items[index]
        
        hero.hp -= 1
        
        if hero.hp <= 0 {
            hero.lives -= 1
            hero.hp = 100
        }
    }
    private func removeCharacters(indexes: [Int]) {
        for index in indexes {
            worker.delete(model.items[index], save: false)
        }
        model.items.remove(atOffsets: .init(indexes))
        worker.save()
        
        if model.items.isEmpty && UserData.balance < 5 {
            UserData.balance = 5
        }
    }
    private func removeBoostEnded(indexes: [Int]) {
        for index in indexes {
            worker.delete(model.boosts[index])
        }
        model.boosts.remove(atOffsets: .init(indexes))
        worker.save()
    }
}
