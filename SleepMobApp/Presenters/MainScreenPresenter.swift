//
//  MainScreenPresenter.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 10.03.2024.
//

import UIKit




// Протокол View для обновления UI
protocol MainScreenDisplayLogic: AnyObject {
    func displayFetchedItems(viewModel: MainScreen.FetchItems.ViewModel)
}

// Пространство имён для организации запросов, ответов и моделей ViewModel
enum MainScreen {
    enum FetchItems {
        struct Response {
            var items: [String] // Исходные данные
        }
        struct ViewModel {
            struct DisplayedItem {
                var name: String // Данные для отображения
            }
            var displayedItems: [DisplayedItem]
        }
    }
}

// Класс MainScreenPresenter
//final class MainScreenPresenter: MainScreenPresentationLogic {
//    weak var viewController: MainScreenDisplayLogic?
//    
//    // Обработка и подготовка данных для отображения
//    func presentFetchedItems(response: MainScreen.FetchItems.Response) {
//        let displayedItems = response.items.map { item -> MainScreen.FetchItems.ViewModel.DisplayedItem in
//            return MainScreen.FetchItems.ViewModel.DisplayedItem(name: item)
//        }
//        
//        let viewModel = MainScreen.FetchItems.ViewModel(displayedItems: displayedItems)
//        viewController?.displayFetchedItems(viewModel: viewModel)
//    }
//}
