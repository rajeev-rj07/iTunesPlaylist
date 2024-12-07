//
//  SongSearchViewModel.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 07/12/24.
//

import Foundation
import Combine

final class SongSearchViewModel: ObservableObject {

    @Published var alertItem: AlertItem?
    @Published var searchText: String = ""
    @Published var songs: [Song] = [Song]()
    @Published var state: FetchState = .good
    @Published var selectedSong: Song?
    
    let limit: Int = 20
    var page: Int = 0

    var cancellables = Set<AnyCancellable>()

    init() {
        $searchText
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchSongs(for: term)
            }.store(in: &cancellables)
    }

    func clear() {
        state = .good
        songs = []
        page = 0
    }

    func loadMore() {
        fetchSongs(for: searchText)
    }

    func fetchSongs(for searchText: String) {

        guard !searchText.isEmpty else {
            return
        }

        guard state == FetchState.good else {
            return
        }

        state = .isLoading

        NetworkManager.shared.fetchSongs(searchTerm: searchText, page: page, limit: limit)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("Error type is: \(error)")
                    self?.state = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] songs in
                for songs in songs.results {
                    self?.songs.append(songs)
                }
                self?.page += 1
                self?.state = (songs.results.count == self?.limit) ? .good : .loadedAll
                print("fetched songs \(songs.resultCount)")
            }.store(in: &cancellables)
    }

    static func example() -> SongSearchViewModel {
        let vm = SongSearchViewModel()
        vm.songs = [Song.example()]
        return vm
    }
}
