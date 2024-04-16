//
//  MainInteractor.swift
//  SleepMobApp
//

import Foundation

final class MainInteractorImp {
    private var presenter: MainPresenter?
    private var router: MainRouter?
    private let cdContext = CoreDataManager.shared.context
    private var model: MainModelDTO
    private var timer: Timer?
    private var boostTimer: Timer?
    private var priceMultiplier: Int = 1
    private var autoClick = false
    
    init(presenter: MainPresenter, model: MainModelDTO) {
        self.presenter = presenter
        self.model = model
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
            cdContext.delete(model.items[index])
        }
        model.items.remove(atOffsets: .init(indexes))
        CoreDataManager.save(context: cdContext)
        
        if model.items.isEmpty && UserData.balance < 5 {
            UserData.balance = 5
        }
    }
    
    private func applyBoost() {
        priceMultiplier = model.boosts.compactMap({ $0.boostType.priceMultiplier }).max() ?? 1
        autoClick = model.boosts.contains(where: { $0.boostType == .fairy })
        
        if let index = model.boosts.firstIndex(where: { $0.boostType == .mask }) {
            model.items.forEach({
                $0.hp = 100
            })
            let boost = model.boosts.remove(at: index)
            cdContext.delete(boost)
            CoreDataManager.save(context: cdContext)
        }
        
        presenter?.show(boosts: model.boosts)
    }
    
    private func removeBoostEnded(indexes: [Int]) {
        for index in indexes {
            cdContext.delete(model.boosts[index])
        }
        model.boosts.remove(atOffsets: .init(indexes))
        CoreDataManager.save(context: cdContext)
    }
    
    private func autoClickAction(index: Int) {
        let hero = model.items[index]
        
        if autoClick {
            if (hero.sleepiness <= 20 && hero.characterState == .awake) ||
                (hero.sleepiness >= 80 && hero.characterState == .asleep) {
                didCharacterTapped(index: index)
            }
        }
    }
}

// MARK: - MainInteractor

extension MainInteractorImp: MainInteractor {
    func set(router: MainRouter) {
        self.router = router
    }
    
    func showCharacters() {
        model.items = FetchRequester.getCharacters(context: cdContext)
        model.boosts = FetchRequester.getBoosts(context: cdContext)
        applyBoost()
        presenter?.show(characters: model.items, balance: UserData.balance)
    }
    
    func didCharacterTapped(index: Int) {
        let hero = model.items[index]
        
        if (hero.sleepiness >= 0 && hero.sleepiness <= 20) ||
            (hero.sleepiness >= 80 && hero.sleepiness <= 100 ) {
            UserData.balance += (1 * priceMultiplier)
        }
        
        hero.characterState = hero.characterState.next
        
        CoreDataManager.save(context: cdContext)
        presenter?.show(characters: model.items, balance: UserData.balance)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            
            var dead = [Int]()
            
            for (index, hero) in model.items.enumerated() {
                autoClickAction(index: index)
                
                if hero.characterState == .asleep {
                    asleepHero(index: index)
                } else if hero.characterState == .awake {
                    awakeHero(index: index)
                }
                
                if hero.lives <= 0 {
                    dead.append(index)
                }
            }
            
            removeCharacters(indexes: dead)
            presenter?.show(characters: model.items, balance: UserData.balance)
        })
        
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
    
    func stopTimer() {
        timer?.invalidate()
        boostTimer?.invalidate()
    }
}
