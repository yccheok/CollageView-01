//
//  UserDataDirectory.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 18/03/2021.
//

import Foundation

enum UserDataDirectory: String {
    case Extract = "extract"
    case Camera = "camera"
    case Mic = "mic"
    case Attachment = "attachment"
    case Recording = "recording"
    case RestoreAttachment = "restore_attachment"
    case RestoreRecording = "restore_recording"
    case Backup = "backup"
    
    func get() -> URL {
        var url = Utils.getUserDataDirectory()
        url.appendPathComponent(self.rawValue)
        return url
    }
}
