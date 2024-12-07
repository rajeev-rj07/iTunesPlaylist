//
//  SongOverviewContextView.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 07/12/24.
//

import SwiftUI

struct SongOverviewContextView: View {

    let song: CDSong
    let size: CGFloat

    var body: some View {
        HStack(alignment: .center) {

            AsyncImage(url: URL(string: song.artworkUrl60 ?? "")) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: size-20)
                    case .failure(_):
                        Color.gray
                            .frame(width: size-20)
                    case .success(let image):
                        image
                            .border(Color(white: 0.8))
                    @unknown default:
                        EmptyView()
                }
            }
            .frame(height: size-20)

            VStack(alignment: .leading) {
                Text(song.trackName ?? "error name")
                    .font(.system(size: 15))
                    .lineLimit(1)
//                    .minimumScaleFactor(0.6)
                    .padding(.top, 8)

                Text("\(song.artistName ?? "error name")")
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
