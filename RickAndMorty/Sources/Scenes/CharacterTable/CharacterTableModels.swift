//
//  CharacterTableModels.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

enum CharacterTable {
    // MARK: - Use cases
    
    enum FetchData {
        struct Request {
        }

        struct Response {
            var characters: [RMCharacter]
        }
        
        struct ViewModel {
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

        struct ViewModel {
            var characters: [[RMCharacter]]
            var sections: [String]
        }
    }
}
