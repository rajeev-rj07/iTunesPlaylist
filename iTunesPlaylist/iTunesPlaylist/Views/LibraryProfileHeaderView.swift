//
//  LibraryProfileHeaderView.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

struct LibraryProfileHeaderView: View {
    var body: some View {
        HStack(spacing: 10) {
            Image("profile")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 35, height: 35)
                .clipShape(.circle)
            Text("Your Library")
                .font(.title)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    LibraryProfileHeaderView()
}
