//
//  CharactersViewModel.swift
//  HarryPotterApp
//
//  Created by Luis Felipe on 22/12/22.
//

import Foundation

protocol CharactersViewModelDelegate: AnyObject {
    func showCharacters()
}

public final class CharactersViewModel {
    
    weak var delegate: CharactersViewModelDelegate?
    
    public var apiService: APIService?
    
    private(set) var charactersList: [Character] = [] {
        didSet {
            delegate?.showCharacters()
        }
    }
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    public func loadCharacters() {
        apiService?.getRequest(endpoint: .characters, type: [Character].self) { [weak self] results in
            
            switch results {
            case .success(let charactersList):
                self?.charactersList = charactersList
//                charactersList.forEach({ character in
//                    if !character.image.isEmpty {
//                        self?.charactersList.append(character)
//                    }
//                })
//                print(self?.charactersList)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
