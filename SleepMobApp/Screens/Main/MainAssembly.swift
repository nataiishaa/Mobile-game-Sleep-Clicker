//
//  MainAssembly.swift
//  SleepMobApp
//

import UIKit

final class MainAssemblyImp: MainAssembly {
    func assemble() -> UIViewController {
        let vc = MainViewController()
        let presenter = MainPresenterImp(view: vc)
        
        let modelDTO: MainModelDTO = .init(
            items: [
                .init(type: .baby),
                .init(type: .student),
                .init(type: .police),
                .init(type: .dad),
                .init(type: .cat),
                .init(type: .bear)
            ]
        )
        let interactor = MainInteractorImp(presenter: presenter, model: modelDTO)
        
        let router = MainRouterImp(interactor: interactor, view: vc)
        interactor.set(router: router)
        
        vc.set(interactor: interactor)
        return vc
    }
}
