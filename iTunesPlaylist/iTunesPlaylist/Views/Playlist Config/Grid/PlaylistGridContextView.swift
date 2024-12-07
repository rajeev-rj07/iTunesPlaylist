//
//  PlaylistGridContextView.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

struct PlaylistGridContextView: View {
    
    let playlist: CDPlaylist
    let size: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            PlaylistGridView(playlist: playlist, size: size)
            
            VStack(alignment: .leading) {
                Text(playlist.name ?? "error name")
                    .font(.system(size: 11))
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                    .padding(.top, 8)
                
                Text("Playlist · \(playlist.songs.count) songs")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
            }
        }
    }
}
//
//#Preview {
//    PlaylistGridContextView(playlist: MockPlaylist.mockPlayList[0], size: (UIScreen.screenWidth*0.5)-20)
//}
