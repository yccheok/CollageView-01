//
//  Utils.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 18/03/2021.
//

import Foundation

extension Utils {
    static func getAttachmentDirectory(_ directory: Directory) -> URL {
        switch directory {
        case .Default:
            return UserDataDirectory.Attachment.get()
        case .Backup:
            // TODO:
            return UserDataDirectory.Attachment.get()
        case .Extract:
            // TODO:
            return UserDataDirectory.Attachment.get()
        }
    }
    
    static func getAttachmentPath(_ directory: Directory, _ name: String) -> URL {
        precondition(!name.isTrimmedEmpty)
        return getAttachmentDirectory(directory).appendingPathComponent(name)
    }
}
