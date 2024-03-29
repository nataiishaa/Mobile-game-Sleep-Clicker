//
//  AboutDevInteractor.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 10.03.2024.
//

import UIKit




// Протоколы для общения Interactor -> Presenter
protocol AboutDevBusinessLogic {
    func fetchDeveloperInfo()
}

// Протокол для передачи данных Interactor -> Presenter
protocol AboutDevDataStore {
    // переменные для хранения данных, полученных интерактором
    var developerInfo: DeveloperInfo? { get }
}

// Модель информации о разработчике для демонстрации
struct DeveloperInfo {
    var name: String
    var role: String
    var bio: String
}

// Класс AboutDevInteractor
final class AboutDevInteractor: AboutDevBusinessLogic, AboutDevDataStore {
    var presenter: AboutDevPresentationLogic?
    var developerInfo: DeveloperInfo?

    // Метод для получения информации о разработчике
    func fetchDeveloperInfo() {
        // Эмуляция загрузки данных
        let info = DeveloperInfo(name: "Nataly Zakharova", role: "iOS Developer", bio: "HSE student.")
        developerInfo = info
        
        // Уведомление презентера после получения данных
        presenter?.presentDeveloperInfo(info: info)
    }
}

// Протокол для общения Interactor -> Presenter
protocol AboutDevPresentationLogic {
    func presentDeveloperInfo(info: DeveloperInfo)
}
