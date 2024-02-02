//
//  MainCoordinator.swift
//  FractalAPI
//
//  Created by Alexandre  Machado on 01/02/24.
//

import Foundation
class MainCoordinator: Coordinator {
    override func start() {
        let viewController = BeersCollectionViewController
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    func mostrarDetalhes() {
        let detalhesCoordinator = DetalhesCoordinator(navigationController: navigationController)
        detalhesCoordinator.start()
    }
}
