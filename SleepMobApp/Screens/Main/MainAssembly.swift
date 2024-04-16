//
//  MainAssembly.swift
//  SleepMobApp
//

import UIKit

final class MainAssemblyImp: MainAssembly {
    func assemble() -> UIViewController {
        let vc = MainViewController()
        let presenter = MainPresenterImp(view: vc)
        
        let modelDTO: MainModelDTO = .init()
        let interactor = MainInteractorImp(presenter: presenter, model: modelDTO)
        
        let router = MainRouterImp(interactor: interactor, view: vc)
        interactor.set(router: router)
        
        vc.set(interactor: interactor)
        return vc
    }
}
