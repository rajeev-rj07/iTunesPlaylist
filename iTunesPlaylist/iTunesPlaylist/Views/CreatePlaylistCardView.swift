//
//  CreatePlaylistCardView.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

struct CreatePlaylistCardView: View {
    
    @Binding var showCreateNewPlaylist: Bool // Binding to show ThirdView
    @Binding var isPresented: Bool

    var body: some View {
        HStack {
            Button {
                isPresented = false

                // Present ThirdView after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    showCreateNewPlaylist = true
                }
            } label: {
                VStack {
                    AppSFImageButton(imageName: SFSymbolImageName.songNote)
                        .foregroundStyle(.secondary)
                    Text("Playlist")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 12))
                }
                .padding()
                VStack(alignment: .leading) {
                    Text("Playlist")
                        .tint(.accentColor)
                        .font(.system(size: 20))
                    Text("Create a playlist with a song")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 16))
                }
                Spacer()
            }
        }
    }
}

#Preview {
    CreatePlaylistCardView(showCreateNewPlaylist: .constant(false), isPresented: .constant(false))
}
