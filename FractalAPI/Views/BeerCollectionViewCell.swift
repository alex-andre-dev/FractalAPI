//
//  BeerCollectionViewCell.swift
//  FractalAPI
//
//  Created by Alexandre Machado on 27/01/24.
//

import UIKit
import SDWebImage

class BeerCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var representedIndentifier: String = ""
    
    private let beerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(hex: "#666666")
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#B1B1B1")
        return label
    }()
    
    
    private let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "down")
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    public func configureCell(title: String, description: String, imageUrl: String){
        titleLabel.text = title
        descriptionLabel.text = description
        if let url = URL(string: imageUrl){
            beerImageView.sd_setImage(with: url, completed: nil)
        }
    }
}

extension BeerCollectionViewCell: ViewProtocol {
    func setupUI() {
        backgroundColor = UIColor(hex: "#F6F6F6")
    }
    
    func setupHierarchy() {
        addSubview(beerImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
    }
    
    func setupConstraints() {
        
        beerImageView.fill(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            trailing: nil,
            bottom: self.bottomAnchor,
            padding: .init(top: 10,left: 5,bottom: 10,right: 0))
        beerImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        titleLabel.fill(
            top: self.topAnchor,
            leading: beerImageView.trailingAnchor,
            trailing: self.trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 10, bottom: 0, right: 25))
        
        descriptionLabel.fill(
            top: titleLabel.bottomAnchor,
            leading: beerImageView.trailingAnchor,
            trailing: self.trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 10, bottom: 0, right: 25))
        
        arrowImageView.fill(
            top: nil,
            leading: nil,
            trailing: self.trailingAnchor,
            bottom: nil,
            padding: .init(top: 30, left: 0, bottom: 30, right: 10))
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
}
