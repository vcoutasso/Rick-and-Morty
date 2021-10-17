//
//  CharacterTableModels.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

enum CharacterTable {
    enum FetchData {
        struct Request {
            let type: RequestType

            enum RequestType {
                case all
            }
        }

        struct Response {
            var characters: [RMCharacter]
        }
        
        struct ViewModel {
            var characters: [RMCharacter]
        }
    }
}
