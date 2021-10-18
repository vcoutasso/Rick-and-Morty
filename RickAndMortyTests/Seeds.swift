//
//  Seeds.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 18/10/21.
//

import XCTest
@testable import RickAndMorty

struct Seeds {
    struct RMCharacters {
        static let rick = RMCharacter(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: .init(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"), location: .init(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2"], url: "https://rickandmortyapi.com/api/character/1", created: "2017-11-04T18:48:46.250Z")

        static let morty = RMCharacter(id: 2, name: "Morty Smith", status: "Alive", species: "Human", type: "", gender: "Male", origin: RickAndMorty.RMCharacter.Origin(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"), location: RickAndMorty.RMCharacter.Location(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"), image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", episode: ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2"], url: "https://rickandmortyapi.com/api/character/2", created: "2017-11-04T18:50:21.651Z")

        static let summer = RMCharacter(id: 3, name: "Summer Smith", status: "Alive", species: "Human", type: "", gender: "Female", origin: RickAndMorty.RMCharacter.Origin(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"), location: RickAndMorty.RMCharacter.Location(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"), image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg", episode: ["https://rickandmortyapi.com/api/episode/6", "https://rickandmortyapi.com/api/episode/7"], url: "https://rickandmortyapi.com/api/character/3", created: "2017-11-04T19:09:56.428Z")
    }
}
