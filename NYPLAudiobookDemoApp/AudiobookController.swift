//
//  AudiobookController.swift
//  NYPLAudiobookToolkitDemoApp
//
//  Created by Dean Silfen on 4/20/18.
//  Copyright © 2018 Dean Silfen. All rights reserved.
//

import UIKit
import NYPLAudiobookToolkit

class AudiobookController {
    var manager: AudiobookManager?
    func configurePlayhead() {
        guard let manager = self.manager else {
            return
        }
        let cachedPlayhead = FileManager.default.contents(atPath: pathFor(audiobookID: manager.audiobook.uniqueIdentifier)!)
        guard let playheadData = cachedPlayhead else {
            return
        }
        
        let decoder = JSONDecoder()
        guard let location = try? decoder.decode(ChapterLocation.self, from: playheadData) else {
            return
        }
        manager.audiobook.player.movePlayheadToLocation(location)
    }

    init() {
        let fileURL = Bundle.main.url(forResource:"ManifestExample", withExtension: "json")!
        let json = try! String(contentsOf: fileURL, encoding: .utf8)

        guard let data = json.data(using: String.Encoding.utf8) else { return }
        let possibleJson = try? JSONSerialization.jsonObject(with: data, options: [])
        guard let unwrappedJSON = possibleJson as? [String: Any] else { return }
        guard let JSONmetadata = unwrappedJSON["metadata"] as? [String: Any] else { return }
        guard let title = JSONmetadata["title"] as? String else {
            NSLog("\(#file): Audiobook manifest failed to parse title key")
            return
        }
        guard let authors = JSONmetadata["author"] as? [String] else {
            NSLog("\(#file): Audiobook manifest failed to parse authors key")
            return
        }
        let metadata = AudiobookMetadata(
            title: title,
            authors: authors
        )
        
        guard let audiobook = ObjCTest.init(string: json).audiobook else { return }
        if (self.manager == nil) {
            self.manager = DefaultAudiobookManager(
                metadata: metadata,
                audiobook: audiobook
            )
        }
    }
    
    func pathFor(audiobookID: String) -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsURL = NSURL(fileURLWithPath: paths.first!, isDirectory: true)
        let fullURL = documentsURL.appendingPathComponent("\(audiobookID).playhead")
        return fullURL?.path
    }

    public func savePlayhead() {
        guard let chapter = self.manager?.audiobook.player.currentChapterLocation else {
            return
        }
        let encoder = JSONEncoder()
        if let encodedChapter = try? encoder.encode(chapter) {
            FileManager.default.createFile(atPath: pathFor(audiobookID: chapter.audiobookID)!, contents: encodedChapter, attributes: nil)
        }
    }
}
