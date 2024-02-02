//
//  MainViewController.swift
//  FractalAPI
//
//  Created by Alexandre  Machado on 27/01/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class BeersCollectionViewController: UICollectionViewController, ViewProtocol {
    
    //MARK: - Properties
    private var viewModel: BeersCollectionViewModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Beer List"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let titleFavoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let noResultsImageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width:300, height: 300))
        iv.image = UIImage(named: "NoResults")
        iv.contentMode = .scaleAspectFit
        iv.isHidden = true
        return iv
    }()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "NO RESULTS WERE FOUND"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        return button
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        return button
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        return button
    }()
    
    private lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.setTitle("Favorites", for: .normal)
        button.setTitleColor(UIColor(hex: "#4A90E2"), for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(hex: "#4A90E2").cgColor
        button.addTarget(self, action: #selector(favoritesTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Initializers
    
    init(collectionViewLayout layout: UICollectionViewLayout, viewModel: BeersCollectionViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        viewModel.fetchMedias { [weak self] error in
            DispatchQueue.main.async {
                if let beers = self?.viewModel.getAllBeers(){
                    self?.viewModel.setAllBeers(beerMedias: beers)
                    self?.viewModel.setAllfilteredBeers()
                }
                self?.collectionView.reloadData()
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        super.viewWillAppear(animated)
    }
    
    //MARK: - Helpers
    
    func setupUI() {
        view.backgroundColor = .green
        setupNavigationBar()
    }
    
    func setupHierarchy() {
        view.addSubview(favoritesButton)
        view.addSubview(noResultsImageView)
        view.addSubview(noResultsLabel)
        
    }
    
    func setupConstraints() {
        favoritesButton.fill(top: nil,
                             leading: nil,
                             trailing: view.trailingAnchor,
                             bottom: view.bottomAnchor,
                             padding: .init(top: 0, left: 0, bottom: 40, right: 40), size: CGSize(width: 100, height: 40))
        noResultsImageView.center = view.center
        noResultsLabel.fill(top: noResultsImageView.bottomAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            bottom: nil,
                            padding: .init(top: -20, left: 80, bottom: 0, right: 80))
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleLabel
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func searchButtonTapped() {
        setupTextField()
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let searchText = textField.text?.lowercased(), !searchText.isEmpty else {
            viewModel.setAllfilteredBeers()
            collectionView.reloadData()
            return
        }
        
        let filteredBeerMedias = viewModel.getAllBeers().filter { item in
            let nameds = item.name.lowercased().contains(searchText)
            return nameds
        }
        viewModel.setFilteredBeers(beerMedias: filteredBeerMedias)
        if filteredBeerMedias.isEmpty {
            noResultsLabel.isHidden = false
            noResultsImageView.isHidden = false
        }
        textField.text = searchText
        
        collectionView.reloadData()
    }
    
    @objc func searchButtonPressed (_ textField: UITextField) {
        titleLabel.text = textField.text
        setupNavigationBar()
        navigationItem.rightBarButtonItem = closeButton
        
    }
    
    @objc func cancelButtonTapped() {
        viewModel.setAllfilteredBeers()
        setupNavigationBar()
        collectionView.reloadData()
        noResultsLabel.isHidden = true
        noResultsImageView.isHidden = true
    }
    
    @objc func closeButtonTapped() {
        titleLabel.text = "Beer List"
        cancelButtonTapped()
        favoritesButton.isHidden = false
        noResultsLabel.isHidden = true
        noResultsImageView.isHidden = true
    }
    
    private func setupCollectionView() {
        collectionView.register(BeerCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func setupTextField(){
        let searchTextField: UITextField = {
            let tf = UITextField()
            tf.placeholder = "Digite algo"
            tf.textAlignment = .natural
            tf.borderStyle = .roundedRect
            tf.keyboardType = .webSearch
            tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            tf.addTarget(self, action: #selector(searchButtonPressed), for: .editingDidEndOnExit)
            
            return tf
        }()
        searchTextField.widthAnchor.constraint(equalToConstant: 320).isActive = true
        navigationItem.titleView = searchTextField
    }
    
    @objc func favoritesTapped(){
        
        let favorites: [Data] = UserDefaults.standard.array(forKey: "Favorites") as? [Data] ?? []
        var favoritesBeers: [BeerMedia] = []
        for item in favorites{
            do {
                let beerMedia = try BeerMedia.fromData(item)
                
                favoritesBeers.append(beerMedia)
            } catch {
                print("Erro ao converter o objeto para Data:", error)
                
            }
        }
        if favoritesBeers.isEmpty {
            noResultsLabel.isHidden = false
            noResultsImageView.isHidden = false
        }
        viewModel.setFilteredBeers(beerMedias: favoritesBeers)
        collectionView.reloadData()
        favoritesButton.isHidden = true
        navigationItem.rightBarButtonItem = closeButton
        navigationItem.titleView = titleFavoritesLabel
        
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfBeersFiltered
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BeerCollectionViewCell
        cell.configureCell(title: viewModel.beerMedia(at: indexPath.item).name,
                           description: viewModel.beerMedia(at: indexPath.item).tagline,
                           imageUrl: viewModel.beerMedia(at: indexPath.item).image_url)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var isFavorited: Bool = false
        let favorites: [Data] = UserDefaults.standard.array(forKey: "Favorites") as? [Data] ?? []
        for item in favorites{
            do {
                let beerMedia = try BeerMedia.fromData(item)
                
                if beerMedia.id == viewModel.beerMedia(at: indexPath.item).id{
                    isFavorited.toggle()
                }
            } catch {
                print("Erro ao converter o objeto para Data:", error)
                
            }
        }
        
        navigationController?.pushViewController(BeerDetailedViewController(viewModel: BeerDetailedViewModel(beerMedia: viewModel.beerMedia(at: indexPath.item), isFavorited: isFavorited)), animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 0, bottom: 8, right: 0)
    }
}

extension BeersCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 1.1
        let height = collectionView.bounds.height / 10
        return .init(width: width, height: height)
    }
    
}
