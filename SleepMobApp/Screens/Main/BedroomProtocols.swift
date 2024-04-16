//
//  MainProtocols.swift
//  SleepMobApp
//

import UIKit
import CoreData

protocol BedroomWorkingLogic {
    func getCharacters() -> [CharacterModel]
    func getBoosts(type: BoostType?) -> [BoostModel]
    func delete(_ object: NSManagedObject)
    func delete(_ object: NSManagedObject, save: Bool)
    func save()
}

protocol BedroomBusinessLogic {
    typealias Model = BedroomModel
    func loadStart(_ request: Model.Start.Request)
    func loadStop(_ request: Model.Stop.Request)
    func loadTap(_ request: Model.Tap.Request)
    // func load(_ request: Model..Request)
}

protocol BedroomPresentationLogic {
    typealias Model = BedroomModel
    func presentStart(_ response: Model.Start.Response)
    // func present(_ response: Model..Response)
}

protocol BedroomDisplayLogic: AnyObject {
    typealias Model = BedroomModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol BedroomRoutingLogic {
    func routeToShop()
}


