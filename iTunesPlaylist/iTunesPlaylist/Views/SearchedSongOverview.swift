//
//  SearchedSongOverview.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 07/12/24.
//

import SwiftUI

struct SearchedSongOverview: View {

    var song: Song?

    var body: some View {
        HStack(alignment: .center) {
            ImageLoadingView(urlString: song?.artworkUrl60 ?? "",
                             size: 55)

            VStack(alignment: .leading) {
                Text(song?.trackName ?? "error name")
                    .font(.system(size: 15))
                    .lineLimit(1)
                    .padding(.top, 8)

                Text("Song · \(song?.artistName ?? "error name")")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .padding(10)
            Spacer()
        }
    }
}

#Preview {
    SearchedSongOverview(song: nil)
}
