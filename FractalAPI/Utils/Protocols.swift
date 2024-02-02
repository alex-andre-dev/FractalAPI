//
//  Protocols.swift
//  FractalAPI
//
//  Created by Alexandre  Machado on 27/01/24.
//

protocol ViewProtocol {
    func setupUI()
    func setupHierarchy()
    func setupConstraints()
    
}
extension ViewProtocol{
    func setupView(){
        setupUI()
        setupHierarchy()
        setupConstraints()
    }
}
