//
//  Coordinator.swift
//  FractalAPI
//
//  Created by Alexandre  Machado on 01/02/24.
//

import Foundation

import UIKit

class Coordinator {
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        fatalError("Método start() deve ser implementado pelos subtipos de Coordinator.")
    }
}
