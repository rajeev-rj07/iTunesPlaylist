//
//  iTunesPlaylistApp.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

@main
struct iTunesPlaylistApp: App {

    let persistanceController = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistanceController.container.viewContext)
        }
    }
}
