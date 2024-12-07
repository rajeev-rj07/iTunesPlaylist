//
//  AlertItem.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 07/12/24.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}


struct AlertContext {

    static let addSongToPlaylist      = AlertItem(title: Text("Add to playlist"),
                                            message: Text("Do you want to add this song to your playlist?"),
                                            dismissButton: .destructive(Text("No")))
}
