//
//  CharactersViewController.swift
//  HarryPotterApp
//
//  Created by Luis Felipe on 21/12/22.
//

import UIKit

public final class CharactersViewController: UIViewController {
    
    var viewModel: CharactersViewModel?
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 16
        return layout
    }()
    
    private lazy var charactersCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CharactersViewCell.self, forCellWithReuseIdentifier: CharactersViewCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        viewModel?.loadCharacters()
    }
    
    private func setupViews() {
        view.backgroundColor = .gray
        view.addSubview(charactersCollectionView)
        viewModel?.delegate = self
        addConstraints()
        setupNavBar()
    }
    
    private func setupNavBar() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .gray
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            charactersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charactersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.charactersList.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersViewCell.reuseId, for: indexPath) as? CharactersViewCell else {
            fatalError()
        }
        cell.character = viewModel?.charactersList[indexPath.row]
        return cell
    }
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError()
        }
        
        let itemsPerLine: CGFloat = 2
        let cellProportion: CGFloat = 200/140
        
        let sectionMargins = flowLayout.sectionInset
        let itemsSpacing = flowLayout.minimumInteritemSpacing
        
        let utilArea = collectionView.bounds.width - (sectionMargins.left +  sectionMargins.right) - itemsSpacing * (itemsPerLine - 1)
        let itemWidth = utilArea / itemsPerLine
        
        return CGSize(width: itemWidth, height: itemWidth * cellProportion)
    }
}

extension CharactersViewController: CharactersViewModelDelegate {
    func showCharacters() {
        DispatchQueue.main.async {
            self.charactersCollectionView.reloadData()
        }
    }
}
