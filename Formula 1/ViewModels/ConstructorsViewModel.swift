//
//  ConstructorsViewModel.swift
//  Formula 1
//
//  Created by Gio on 11/8/19.
//  Copyright © 2022 Gio. All rights reserved.
//

import Foundation
import Combine

// MARK: - Constructors View Model
class ConstructorsViewModel: ObservableObject {
    // MARK: - Singleton Instance
    static let shared = ConstructorsViewModel()
    
    // MARK: - Properties
    // using @Published for when implementing with SwiftUI
    @Published private var constructors = [ConstructorStanding]()
    
    private var cancellables: Set<AnyCancellable>
    
    var numberOfConstructors: Int { constructors.count }
    
    weak var delegate: Fetchable?
    
    // MARK: - init
    private init() {
        cancellables = []
        fetch()
    }
}

// MARK: - Functions
extension ConstructorsViewModel {
    private func fetch() {
       
            WebService
                .fetch(.constructorStandings)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                }, receiveValue: { (response: Constructors) in
                    let standingsList = response.mrData.standingsTable.standingsLists
                    self.constructors = standingsList.first?.constructorStandings ?? []
                    
                    self.delegate?.didFinishFetching()
                }).store(in: &cancellables)
    }
    
    func constructor(at index: Int) -> ConstructorStanding { constructors[index] }
}

// MARK: - Private Codable structs
private struct Constructors: Codable {
    let mrData: MRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

struct MRData: Codable {
    let standingsTable: StandingsTable

    enum CodingKeys: String, CodingKey {
        case standingsTable = "StandingsTable"
    }
}

struct StandingsTable: Codable {
    let standingsLists: [StandingsList]

    enum CodingKeys: String, CodingKey {
        case standingsLists = "StandingsLists"
    }
}

struct StandingsList: Codable {
    let season, round: String
    let constructorStandings: [ConstructorStanding]

    enum CodingKeys: String, CodingKey {
        case season, round
        case constructorStandings = "ConstructorStandings"
    }
}
