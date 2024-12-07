//
//  PlaylistModel.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import Foundation

//struct PlaylistModel: Codable, Identifiable {
//    let id: Int
//    let name: String
//    let songs: [SongModel]
//}

struct PlaylistModel: Codable, Identifiable {
    let id: Int
    let name: String
    let songs: [Song]
}

struct MockPlaylist {

    static let mockPlayList = [
        PlaylistModel(id: 1, name: "mock playlist one", songs: [Song.example(),
                                                                Song.example2(),
                                                                Song.example(),
                                                                Song.example2()]),

        PlaylistModel(id: 2, name: "mock playlist two", songs: [Song.example(),
                                                                Song.example2(),
                                                                Song.example()]),

        PlaylistModel(id: 3, name: "mock playlist three", songs: [Song.example(),
                                                                Song.example2()]),

        PlaylistModel(id: 4, name: "mock playlist four", songs: [Song.example()])
    ]

//    static let mockPlayList = [
//        
//        PlaylistModel(id: 1, name: "Name name name Name name name", songs: [SongModel(id: 1, imageName: "album_art"),
//                                     SongModel(id: 2, imageName: "album_art"),
//                                     SongModel(id: 3, imageName: "album_art"),
//                                     SongModel(id: 4, imageName: "album_art")]),
//        
//        PlaylistModel(id: 2, name: "Name name name", songs: [SongModel(id: 1, imageName: "album_art"),
//                                     SongModel(id: 2, imageName: "album_art"),
//                                     SongModel(id: 3, imageName: "album_art")]),
//        
//        PlaylistModel(id: 3, name: "Name name", songs: [SongModel(id: 1, imageName: "album_art"),
//                                     SongModel(id: 2, imageName: "album_art")]),
//        
//        PlaylistModel(id: 4, name: "Name", songs: [SongModel(id: 1, imageName: "album_art")]),
//        
//        PlaylistModel(id: 5, name: "Name name name name", songs: [SongModel(id: 1, imageName: "album_art"),
//                                     SongModel(id: 2, imageName: "album_art"),
//                                     SongModel(id: 3, imageName: "album_art"),
//                                     SongModel(id: 4, imageName: "album_art")]),
//        
//        PlaylistModel(id: 6, name: "Name name name", songs: [SongModel(id: 1, imageName: "album_art"),
//                                     SongModel(id: 2, imageName: "album_art"),
//                                     SongModel(id: 3, imageName: "album_art")]),
//        
//        PlaylistModel(id: 7, name: "Name name", songs: [SongModel(id: 1, imageName: "album_art"),
//                                     SongModel(id: 2, imageName: "album_art")]),
//        
//        PlaylistModel(id: 8, name: "Name", songs: [SongModel(id: 1, imageName: "album_art")])
//    ]
}
