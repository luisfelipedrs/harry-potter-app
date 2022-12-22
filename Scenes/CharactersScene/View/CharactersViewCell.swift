//
//  CharactersViewCell.swift
//  HarryPotterApp
//
//  Created by Luis Felipe on 21/12/22.
//

import UIKit
import Kingfisher

public final class CharactersViewCell: UICollectionViewCell {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
    var character: Character? {
        didSet {
            guard let character = character else { return }
            characterNameLabel.text = character.name
            setupImageViewFor(character: character)
        }
    }
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var labelContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.66)
        view.addSubview(characterNameLabel)
        return view
    }()
    
    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageViewFor(character: Character) {
        if !character.image.isEmpty {
            characterImageView.kf.setImage(with: URL(string: character.image))
        } else {
            characterImageView.image = UIImage(systemName: "questionmark")
            characterImageView.contentMode = .scaleAspectFill
            characterImageView.tintColor = .gray
        }
    }
    
    private func addViews() {
        addSubview(characterImageView)
        addSubview(labelContainerView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: self.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            labelContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            labelContainerView.heightAnchor.constraint(equalTo: characterImageView.heightAnchor, multiplier: 0.15),
            
            characterNameLabel.centerXAnchor.constraint(equalTo: labelContainerView.centerXAnchor),
            characterNameLabel.centerYAnchor.constraint(equalTo: labelContainerView.centerYAnchor)
        ])
    }
}
