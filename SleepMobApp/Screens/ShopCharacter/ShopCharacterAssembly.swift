//
//  ShopCharacterAssembly.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 29.03.2024.
//

import UIKit

final class ShopCharacterAssemblyImp: ShopCharacterAssembly {
    func assemble() -> UIViewController {
        let sc = ShopCharacterViewController()
        let presenter = ShopCharacterPresenterImp(view: sc)
        
        let modelDTO: ShopCharacterModelDTO = .init(
            items: [
                .init(type: .cap1),
                .init(type: .cap2),
                .init(type: .mask),
                .init(type: .fairy),
             
            ]
        )
        let interactor = ShopCharacterInteractorImp(presenter: presenter, model: modelDTO)
        
        let router = ShopCharacterRouterImp(interactor: interactor, view: sc)
        interactor.set(router: router)
        
        sc.set(interactor: interactor)
        return sc
    }
}

