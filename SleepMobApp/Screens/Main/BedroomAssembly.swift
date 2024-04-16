//
//  MainAssembly.swift
//  SleepMobApp
//

import UIKit

enum BedroomAssembly {
    static func build() -> UIViewController {
        let router: BedroomRouter = BedroomRouter()
        let presenter: BedroomPresenter = BedroomPresenter()
        let interactor: BedroomInteractor = BedroomInteractor(presenter: presenter)
        let viewController: BedroomViewController = BedroomViewController(
            router: router,
            interactor: interactor
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}

