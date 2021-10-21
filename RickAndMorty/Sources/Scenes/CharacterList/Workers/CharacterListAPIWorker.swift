//
//  CharacterListAPIWorker.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

protocol CharacterListAPIWorkerProtocol {
    func fetchAllCharacters(completion: @escaping ([RMCharacter]) -> Void)
    func fetchCurrentPage(completion: @escaping ([RMCharacter]) -> Void)
}

class CharacterListAPIWorker: CharacterListAPIWorkerProtocol {
    let baseUrl = "https://rickandmortyapi.com/api/character"
    var currentPage: Int = 1
    var lastPage: Int?

    var requestUrl: URL? {
        URL(string: baseUrl + "/?page=\(currentPage)")
    }

    func fetchAllCharacters(completion: @escaping ([RMCharacter]) -> Void) {
        var allCharacters = [RMCharacter]()

        currentPage = 1

        lazy var pageCompletion: ([RMCharacter]) -> Void = { [weak self] pageCharacters in
            guard let self = self, !pageCharacters.isEmpty else { return }

            allCharacters.append(contentsOf: pageCharacters)
            self.currentPage += 1

            guard let lastPage = self.lastPage else {
                print("Did not get last page number. Aborting request")
                return
            }

            if self.currentPage < lastPage {
                self.fetchCurrentPage(completion: pageCompletion)
            } else {
                completion(allCharacters)
            }
        }

        fetchCurrentPage(completion: pageCompletion)
    }

    func fetchCurrentPage(completion: @escaping ([RMCharacter]) -> Void) {
        guard let requestUrl = requestUrl else { return }

        URLSession.shared.dataTask(with: requestUrl) { [weak self] data, urlResponse, error in
            if let error = error {
                print(error.localizedDescription)
            }

            guard let urlResponse = urlResponse as? HTTPURLResponse,
                  let data = data else {
                      print("Did not get response or data")
                      return
                  }

            // If response is not OK
            if urlResponse.statusCode != 200 {
                return
            }

            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(RequestResponse<RMCharacter>.self, from: data) else {
                print("Could not decode request result")
                return
            }

            if let pages = response.info.pages {
                self?.lastPage = pages
            }

            completion(response.results)
        }.resume()
    }
}
