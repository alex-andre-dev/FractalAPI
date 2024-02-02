//
//  BeerDetailedViewController.swift
//  FractalAPI
//
//  Created by Alexandre  Machado on 28/01/24.
//

import UIKit

class BeerDetailedViewController: UIViewController, ViewProtocol {
    
    //MARK: - Properties
    
    private var viewModel: BeerDetailedViewModel
    
    private let beerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor(hex: "#666666")
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(hex: "#666666")
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "#B1B1B1")
        return label
    }()
    
    private lazy var favoriteButton: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(favorited), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }()
    //MARK: - Initializers
    
    init(viewModel: BeerDetailedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Helpers
    
    
    func setImage(){
        let imageName = viewModel.isFavorited ? "star.fill" : "star"
        let systemImage = UIImage(systemName: imageName)
        if let button = navigationItem.rightBarButtonItem?.customView as? UIButton {
            button.setImage(systemImage, for: .normal)
        }
    }
    
    @objc func favorited(){
        viewModel.isFavorited.toggle()
        setImage()
        viewModel.favorited()
    }
    
    func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .white
        
        let beerMedia = viewModel.getBeerMedia()
        if let url = URL(string: beerMedia.image_url){
            beerImageView.sd_setImage(with: url, completed: nil)
        }
        titleLabel.text = beerMedia.name
        subtitleLabel.text = beerMedia.tagline
        descriptionLabel.text = beerMedia.description
        setImage()
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Beer Details"
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = favoriteButton
        
    }
    
    func setupHierarchy() {
        view.addSubview(beerImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        beerImageView.fill(top: view.topAnchor,
                           leading: view.leadingAnchor,
                           trailing: nil,
                           bottom: nil,
                           padding: .init(top: 27, left: 17, bottom: 0, right: 0))
        beerImageView.widthAnchor.constraint(equalToConstant: 74).isActive = true
        beerImageView.heightAnchor.constraint(equalToConstant: 74).isActive = true
        
        titleLabel.fill(top: beerImageView.topAnchor,
                        leading: beerImageView.trailingAnchor,
                        trailing: view.trailingAnchor,
                        bottom: nil,
                        padding: .init(top: 11, left: 16, bottom: 0, right: 17))
        
        subtitleLabel.fill(top: titleLabel.bottomAnchor,
                           leading: titleLabel.leadingAnchor,
                           trailing: nil,
                           bottom: nil,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        descriptionLabel.fill(top: beerImageView.bottomAnchor,
                              leading: beerImageView.leadingAnchor,
                              trailing: view.trailingAnchor,
                              bottom: nil,
                              padding: .init(top: 33, left: 17, bottom: 0, right: 17))
        
        
    }
    
}
