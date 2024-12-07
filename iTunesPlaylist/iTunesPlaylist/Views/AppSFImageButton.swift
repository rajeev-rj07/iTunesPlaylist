//
//  AppSFImageButton.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

struct AppSFImageButton: View {
    
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .imageScale(.large)
            .frame(width: 26, height: 26)
    }
}

#Preview {
    AppSFImageButton(imageName: SFSymbolImageName.plus)
}
