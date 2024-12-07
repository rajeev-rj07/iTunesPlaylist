//
//  CDPlaylist+CoreDataProperties.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 07/12/24.
//
//

import Foundation
import CoreData


extension CDPlaylist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPlaylist> {
        return NSFetchRequest<CDPlaylist>(entityName: "CDPlaylist")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var playlistToSong: Set<CDSong>?

    public var songs: [CDSong] {
        return Array(playlistToSong ?? [])
    }
}

// MARK: Generated accessors for playlistToSong
extension CDPlaylist {

    @objc(addPlaylistToSongObject:)
    @NSManaged public func addToPlaylistToSong(_ value: CDSong)

    @objc(removePlaylistToSongObject:)
    @NSManaged public func removeFromPlaylistToSong(_ value: CDSong)

    @objc(addPlaylistToSong:)
    @NSManaged public func addToPlaylistToSong(_ values: NSSet)

    @objc(removePlaylistToSong:)
    @NSManaged public func removeFromPlaylistToSong(_ values: NSSet)

}

extension CDPlaylist : Identifiable {

}
