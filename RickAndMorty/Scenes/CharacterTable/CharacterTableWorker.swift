//
//  CharacterTableWorker.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

class CharacterTableWorker {
    typealias RMCharacter = CharacterTable.Character
    let apiUrl = URL(string: "https://rickandmortyapi.com/api/character")!

    func fetchAllCharacters(completion: @escaping ([RMCharacter]) -> Void) {
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }

            guard let response = response as? HTTPURLResponse,
                  let data = data else {
                      print("Did not get response or data")
                      return
                  }

            // TODO: Handle response cases
            switch response.statusCode {
            default:
                break
            }

            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(RequestResult<RMCharacter>.self, from: data) else {
                print("Could not decode request result")
                return
            }

            completion(result.results)
        }.resume()
    }
}
