//
//  CharacterListModels.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

enum CharacterList {
    // MARK: - Use cases
    
    enum FetchData {
        struct Request {
        }

        struct Response {
            var characters: [RMCharacter]
        }
        
        struct ViewModel: Equatable {
            var characters: [[RMCharacter]]
            var sections: [String]
        }
    }

    enum FilterData {
        struct Request{
            let searchText: String
        }

        struct Response {
            var characters: [RMCharacter]
        }

        struct ViewModel: Equatable {
            var characters: [[RMCharacter]]
            var sections: [String]
        }
    }
}
