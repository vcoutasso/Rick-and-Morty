//
//  CharacterTableWorker.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

class CharacterTableWorker {
    let apiUrl = URL(string: "https://rickandmortyapi.com/api/character")!

    func fetchAllCharacters(completion: @escaping () -> Void) {
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }

            guard let response = response, let data = data else { return }

            print(data)
            
            completion()
        }.resume()
    }
}
