//
//  ShopAssembly.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//
import UIKit

final class ShopAssemblyImp: ShopAssembly {
    func assemble() -> UIViewController {
        let sc = ShopViewController()
        let presenter = ShopPresenterImp(view: sc)
        
        let modelDTO: ShopModelDTO = .init(
            items: [
                .init(type: .cap1),
                .init(type: .cap2),
                .init(type: .mask),
                .init(type: .fairy),
             
            ]
        )
        let interactor = ShopInteractorImp(presenter: presenter, model: modelDTO)
        
        let router = ShopRouterImp(interactor: interactor, view: sc)
        interactor.set(router: router)
        
        sc.set(interactor: interactor)
        return sc
    }
}
