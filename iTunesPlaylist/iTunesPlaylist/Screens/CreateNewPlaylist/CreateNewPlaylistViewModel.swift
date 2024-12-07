//
//  CreateNewPlaylistViewModel.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 07/12/24.
//

import Foundation

final class CreateNewPlaylistViewModel: ObservableObject{

    @Published var playlistName: String = ""
    @Published var isPresented: Bool = false
    @Published var showPlayListDetailsView: Bool = false
    @Published var tempNewPlaylistName: String = ""

}
