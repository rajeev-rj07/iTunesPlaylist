//
//  PlaylistDetailView.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

struct PlaylistDetailView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest var songs: FetchedResults<CDSong>

    @StateObject var viewModel = PlaylistDetailViewModel()

    var playlist: CDPlaylist?
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDPlaylist.name, ascending: false)]) private var savedPlaylists: FetchedResults<CDPlaylist>


    init(playlist: CDPlaylist?) {
        self.playlist = playlist
        if let playlist = playlist {
            _songs = FetchRequest<CDSong>(
                entity: CDSong.entity(),
                sortDescriptors: [],
                predicate: NSPredicate(format: "songToPlaylist == %@", playlist)
            )
        } else {
            _songs = FetchRequest<CDSong>(entity: CDSong.entity(), sortDescriptors: [])
        }
    }

    var body: some View {
//        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    TopGradientView(height: geometry.size.height/4, color: Color(hex: "#5628F8"))
                        .edgesIgnoringSafeArea(.all)
                }
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(playlist?.name ?? "error name")
                                .font(.system(size: 19, weight: .medium, design: .default))
                                .tint(.accentColor)
                            Text("\(playlist?.songs.count ?? 0) songs")
                                .font(.system(size: 12, weight: .medium, design: .default))
                                .tint(.accentColor)
                        }
                        .padding()
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    Spacer()
                    List {
                        ForEach(songs) { song in
                            SongOverviewContextView(song: song, size: 60)
                                .padding(.vertical, 5)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarBackButtonHidden(true) // Hide the default back button
            .toolbar {
                // Leading toolbar button (Custom Back)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Dismiss the view to go back
                    }) {
                        Image(systemName: "arrow.backward")
                            .imageScale(.medium)
                            .font(.title3)
                    }
                }

                // Trailing toolbar button (Plus)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.isShowingSongSearchView = true
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.medium)
                            .font(.title3)
                    }
                    .fullScreenCover(isPresented: $viewModel.isShowingSongSearchView, content: {
                        SongSearchView(isPresented: $viewModel.isShowingSongSearchView, associatedPlaylist: playlist)
                    })
                }
            }
//        }
    }
}

#Preview {
    NavigationStack {
        PlaylistDetailView(playlist: nil)
    }
}
