//
//  Attachment.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 15/03/2021.
//

import Foundation

struct Attachment : Hashable {
    let directory: Directory
    let name: String
    let width: Double
    let height: Double
    
    func getPath() -> URL {
        return Utils.getAttachmentPath(directory, name)
    }
    
    func isSameSize(_ attachment: Attachment) -> Bool {
        return width == attachment.width && height == attachment.height
    }
}
