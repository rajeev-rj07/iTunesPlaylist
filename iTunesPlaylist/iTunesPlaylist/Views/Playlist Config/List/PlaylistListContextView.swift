//
//  PlaylistListContextView.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

struct PlaylistListContextView: View {
    
    let playlist: CDPlaylist
    let size: CGFloat
    
    var body: some View {
        HStack(alignment: .center) {
            PlaylistGridView(playlist: playlist, size: size-17)
            
            VStack(alignment: .leading) {
                Text(playlist.name ?? "name error")
                    .font(.system(size: 15))
                    .lineLimit(1)
//                    .minimumScaleFactor(0.6)
                    .padding(.top, 8)
                
                Text("Playlist · \(playlist.songs.count) songs")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .padding(10)
            Spacer()
            Button {
                print("three dot tapped")
            }label: {
                AppSFImageButton(imageName: "ellipsis")
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(90))
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

//#Preview {
//    PlaylistListContextView(playlist: MockPlaylist.mockPlayList[0], size: 67)
//}
