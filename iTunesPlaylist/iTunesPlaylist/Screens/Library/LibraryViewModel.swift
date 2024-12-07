//
//  LibraryViewModel.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

final class LibraryViewModel: ObservableObject {

    let gridColumns = [GridItem(.flexible(), spacing: 10),
                       GridItem(.flexible(), spacing: 10)]
    
    let sizeOfLazyGridCell = (UIScreen.screenWidth*0.5)-20
    @Published var shouldSwitchGridView = true
    @Published var sheetHeight: CGFloat = .zero

    @Published var isShowingCardView = false
    @Published var isShowingCreatePlaylistView = false
    @Published var isShowingPlaylistDetailView = false

    @Published var tempNewPlaylistName = ""

    @Published var newPlaylist: CDPlaylist?
}
