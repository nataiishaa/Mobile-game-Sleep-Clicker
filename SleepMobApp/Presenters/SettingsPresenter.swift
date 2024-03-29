//
//  SettingsPresenter.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 10.03.2024.
//
import Foundation

// Протоколы для общения Presenter -> ViewController
//protocol SettingsPresentationLogic {
//    func presentSaveResult(success: Bool)
//}

// Протокол View для обновления UI
protocol SettingsDisplayLogic: AnyObject {
    func displaySaveResult(viewModel: Settings.SaveSettings.ViewModel)
}

// Пространство имён для организации запросов, ответов и моделей ViewModel
enum Settings {
    enum SaveSettings {
        struct ViewModel {
            var message: String // Данные для отображения результата сохранения настроек
        }
    }
}

// Класс SettingsPresenter
//final class SettingsPresenter: SettingsPresentationLogic {
//    weak var viewController: SettingsDisplayLogic?
//    
//    // Метод для обработки результата сохранения настроек и подготовки данных для отображения
//    func presentSaveResult(success: Bool) {
//        let message = success ? "Настройки успешно сохранены" : "Не удалось сохранить настройки"
//        let viewModel = Settings.SaveSettings.ViewModel(message: message)
//        viewController?.displaySaveResult(viewModel: viewModel)
//    }
//}
//
//extension SettingsViewController: SettingsDisplayLogic {
//    func displaySaveResult(viewModel: Settings.SaveSettings.ViewModel) {
//        showAlert(withMessage: viewModel.message)
//    }
//
//    private func showAlert(withMessage message: String) {
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
//    }
//}
