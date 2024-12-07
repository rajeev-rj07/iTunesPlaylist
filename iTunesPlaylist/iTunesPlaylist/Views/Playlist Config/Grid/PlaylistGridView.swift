//
//  PlaylistGridView.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

struct PlaylistGridView: View {
    let playlist: CDPlaylist // Array of image names
    let size: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            if playlist.songs.count == 1 {
                // 1 image: Full 120x120
                centeredImageView(url: playlist.songs[0].artworkUrl60 ?? "")
                    .frame(width: size, height: size)
                    .onAppear {
                        print("[onAppear 21] playlist \(playlist.name ?? "") has \(playlist.songs.count) songs")
                    }
            } else if playlist.songs.count == 2 {
                // 2 images: Split 60x120
                HStack(spacing: 0) {
                    centeredImageView(url:playlist.songs[0].artworkUrl60 ?? "")
                    centeredImageView(url:playlist.songs[1].artworkUrl60 ?? "")
                }
                .frame(height: size)
                .onAppear {
                    print("[onAppear 31] playlist \(playlist.name ?? "") has \(playlist.songs.count) songs")
                }
            } else if playlist.songs.count == 3 {
                // 3 images: 2 on top (60x60 each), 1 full width (120x60)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        centeredImageView(url:playlist.songs[0].artworkUrl60 ?? "")
                        centeredImageView(url:playlist.songs[1].artworkUrl60 ?? "")
                    }
                    .frame(height: size/2)

                    centeredImageView(url:playlist.songs[2].artworkUrl60 ?? "")
                        .frame(height: size/2)
                }
                .frame(height: size)
                .onAppear {
                    print("[onAppear 47] playlist \(playlist.name ?? "") has \(playlist.songs.count) songs")
                }
            } else if playlist.songs.count >= 4 {
                // 4 images: 2 on top, 2 on bottom (60x60 each)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        centeredImageView(url:playlist.songs[0].artworkUrl60 ?? "")
                        centeredImageView(url:playlist.songs[1].artworkUrl60 ?? "")
                    }
                    .frame(height: size/2)
                    
                    HStack(spacing: 0) {
                        centeredImageView(url:playlist.songs[2].artworkUrl60 ?? "")
                        centeredImageView(url:playlist.songs[3].artworkUrl60 ?? "")
                    }
                    .frame(height: size/2)
                }
                .frame(height: size)
                .onAppear {
                    print("[onAppear 66] playlist \(playlist.name ?? "") has \(playlist.songs.count) songs")
                }
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: size, height: size)
                    .onAppear {
                        print("[onAppear 73] playlist \(playlist.name ?? "") has \(playlist.songs.count) songs")
                    }
            }
        }
        .onAppear {
            print("[onAppear 78] playlist \(playlist.name ?? "") has \(playlist.songs.count) songs")
        }
        .frame(width: size, height: size) // Always keep the frame 120x120
        .clipped()
    }
    
    // A view for centering the content of the image
    private func centeredImageView(url: String) -> some View {
        GeometryReader { geometry in

            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: size)
                        .onAppear {
                            print("[onAppear 94] playlist \(playlist.name ?? "") has \(playlist.songs.count) songs")
                        }
                case .failure(_):
                    Color.gray
                        .frame(width: size)
                        .onAppear {
                            print("[onAppear 100] playlist \(playlist.name ?? "") has \(playlist.songs.count) songs")
                        }
                case .success(let image):
                    image
                        .resizable()
                        .border(Color(white: 0.8))
                        .onAppear {
                            print("[onAppear 107] playlist \(playlist.name ?? "") has \(playlist.songs.count) songs")
                        }
                @unknown default:
                    EmptyView()
                        .onAppear {
                            print("[onAppear 112] playlist \(playlist.name ?? "") has \(playlist.songs.count) songs")
                        }
                }
            }
            .scaledToFill()
            .frame(width: size, height: size) // Ensure the image fills the frame
            .clipped() // Clip any content outside the bounds
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .clipped()
    }
}

//#Preview {
//    PlaylistGridView(playlist: MockPlaylist.mockPlayList[0], size: 300)
//}
