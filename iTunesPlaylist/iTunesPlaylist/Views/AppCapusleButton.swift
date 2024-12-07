//
//  AppCapusleButton.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

struct AppCapusleButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.system(size: 11))
            .fontWeight(.light)
            .frame(width: 70)
            .padding(8)
            .overlay(
                Capsule(style: .continuous)
                    .stroke(style: StrokeStyle(lineWidth: 1))
            )
    }
}

#Preview {
    AppCapusleButton(title: "Playlists")
}

