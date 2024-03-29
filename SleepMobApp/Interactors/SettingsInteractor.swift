//
//  SettingsInteractor.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 10.03.2024.
//
import UIKit

// Протоколы для общения Interactor -> Presenter
protocol SettingsBusinessLogic {
    func saveSettings(settings: SettingsModel)
}

// Протокол для передачи данных Interactor -> Presenter
protocol SettingsDataStore {
    // Для хранения данных
    var settings: SettingsModel? { get set }
}

// Модель настроек для примера
struct SettingsModel {
    var someSetting: Bool
}

// Класс SettingsInteractor
final class SettingsInteractor: SettingsBusinessLogic, SettingsDataStore {
    var presenter: SettingsPresentationLogic?
    var settings: SettingsModel?

    // Метод для сохранения настроек
    func saveSettings(settings: SettingsModel) {
        // Сохранение настроек   self.settings = settings
        presenter?.presentSaveResult(success: true)
    }
}

// Протокол для общения Interactor -> Presenter
protocol SettingsPresentationLogic {
    func presentSaveResult(success: Bool)
}
