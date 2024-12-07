//
//  LibraryView.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

struct LibraryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var predicate: NSPredicate? = nil
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDPlaylist.name, ascending: false)]) private var savedPlaylists: FetchedResults<CDPlaylist>

    @StateObject var viewModel = LibraryViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    LibraryProfileHeaderView()
                        .padding()
                    Spacer()
                    Button {
                        print("Add button tapped")
                        viewModel.isShowingCardView = true
                    } label: {
                        AppSFImageButton(imageName: SFSymbolImageName.plus)
                    }
                    .sheet(isPresented: $viewModel.isShowingCardView) {
                        CreatePlaylistCardView(showCreateNewPlaylist: $viewModel.isShowingCreatePlaylistView, isPresented: $viewModel.isShowingCardView)
                            .fixedSize(horizontal: false, vertical: true)
                            .modifier(SheetHeightModifer(height: $viewModel.sheetHeight))
                            .presentationDetents([.height(viewModel.sheetHeight)])
                    }
                    .sheet(isPresented: $viewModel.isShowingCreatePlaylistView) {
                        CreateNewPlaylist(savedPlaylist: $viewModel.newPlaylist, showPlayListDetailsView: $viewModel.isShowingPlaylistDetailView, isPresented: $viewModel.isShowingCreatePlaylistView, tempNewPlaylistName: $viewModel.tempNewPlaylistName)
                    }
                    .padding(.trailing)
                }
                HStack {
                    Button {
                        print("Playlist button tapped")
                    } label: {
                        AppCapusleButton(title: "Playlists")
                    }
                    .padding()
                    Spacer()
                }
                HStack {
                    Label("Most Recent", systemImage: SFSymbolImageName.arrowUpDown)
                        .padding()
                    Spacer()
                    Button {
                        viewModel.shouldSwitchGridView = !viewModel.shouldSwitchGridView
                    } label: {
                        AppSFImageButton(imageName: SFSymbolImageName.grid)
                            .padding(.trailing)
                    }
                }
                if viewModel.shouldSwitchGridView {
                    ScrollView {
                        LazyVGrid(columns: viewModel.gridColumns, spacing: 20) {
                            ForEach(savedPlaylists) { playlist in
                                PlaylistGridContextView(playlist: playlist, size: viewModel.sizeOfLazyGridCell)
                            }
                        }
                    }
                    .padding(.leading).padding(.trailing)
                } else {
                    List {
                        ForEach(savedPlaylists) { playlist in
                            PlaylistListContextView(playlist: playlist, size: 84)
                                .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .onAppear {
                // HACK APPLIED NEED TO IMPROVE!!!!!!!
                #warning("I had to add this hack because swiftui is acting very weird and not updating the context to trigger a list or grid view refresh. Could not find any solution for now.")
                viewModel.shouldSwitchGridView = !viewModel.shouldSwitchGridView
            }
            .navigationDestination(isPresented: $viewModel.isShowingPlaylistDetailView) {
                PlaylistDetailView(playlist: viewModel.newPlaylist)
            }
        }
    }
}

#Preview {
    LibraryView()
}
