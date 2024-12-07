//
//  SongSearchView.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 07/12/24.
//

import SwiftUI
import Combine

struct SongSearchView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @FocusState private var isTextFieldFocused: Bool
    @State private var isEditing = true
    @Binding var isPresented: Bool
    @StateObject var viewModel = SongSearchViewModel()
    var associatedPlaylist: CDPlaylist?

    var body: some View {
        VStack {
            AppSearchBar(text: $viewModel.searchText, isEditing: $isEditing)
                .navigationTitle("Search")
            Spacer()
            List {
                ForEach(viewModel.songs) { song in
                    HStack {
                        SearchedSongOverview(song: song)
                            .padding(.vertical, 10)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // Pass the song to the view model (not the binding)
                        viewModel.selectedSong = song
                        // Optionally, update the alert context based on the selected song
                        viewModel.alertItem = AlertContext.addSongToPlaylist
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }

                switch viewModel.state {
                    case .good:
                        Color.clear
                            .onAppear {
                                viewModel.loadMore()
                            }
                    case .isLoading:
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(maxWidth: .infinity)
                    case .loadedAll:
                        EmptyView()
                    case .error(let message):
                        Text(message)
                            .foregroundColor(.pink)
                }
            }
            .listStyle(.plain)
            .padding(.top)
        }
        .onChange(of: isEditing) { newValue in
            if !newValue {
                isPresented = false
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  primaryButton: .default(Text("Add"), action: {
                addSongToPlayList()
                isPresented = false
            }),
                  secondaryButton: alertItem.dismissButton)
        }
    }

    private func addSongToPlayList() {
        guard (associatedPlaylist != nil) else {
            print("associatedPlaylist is nil")
            return
        }
        let song = CDSong(context: viewContext)
        song.id = UUID()
        song.artistName = viewModel.selectedSong?.artistName
        song.trackName = viewModel.selectedSong?.trackName
        song.artworkUrl60 = viewModel.selectedSong?.artworkUrl60
        song.previewURL = viewModel.selectedSong?.previewURL
        song.songToPlaylist = associatedPlaylist

        do {
            try viewContext.save()
        } catch {
            print("An error occured: \(error.localizedDescription)")
        }

    }
}

#Preview {
    SongSearchView(isPresented: .constant(false))
}
