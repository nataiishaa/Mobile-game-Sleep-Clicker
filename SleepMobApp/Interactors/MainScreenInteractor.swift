//
//  MainScreenInteractor.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 10.03.2024.
//

import UIKit


// Протоколы для общения Interactor -> Presenter
protocol MainScreenBusinessLogic {
    func fetchItems()
}

// Протокол для передачи данных Interactor -> Presenter
protocol MainScreenDataStore {
    // Переменные для хранения данных
    var items: [String] { get }
}

// Класс MainScreenInteractor
final class MainScreenInteractor: MainScreenBusinessLogic, MainScreenDataStore {
    var presenter: MainScreenPresentationLogic?
    var worker: MainScreenWorker?
    var items: [String] = []

    // Метод для запроса данных
    func fetchItems() {
        worker = MainScreenWorker()
        worker?.fetchItems { [weak self] (items) in
            self?.items = items
            self?.presenter?.presentFetchedItems(items: items)
        }
    }
}

// Пример класса Worker для загрузки данных
final class MainScreenWorker {
    func fetchItems(completion: ([String]) -> Void) {
        // Загрзука данных
        let items = ["Item 1", "Item 2", "Item 3"]
        completion(items)
    }
}

// Протокол для общения Interactor -> Presenter
protocol MainScreenPresentationLogic {
    func presentFetchedItems(items: [String])
}
