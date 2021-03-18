//
//  Utils.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 18/03/2021.
//

import Foundation

enum Utils {
    private static var userDataDirectory: URL?
    
    static func getUserDataDirectory() -> URL {
        if let userDataDirectory = Utils.userDataDirectory {
            return userDataDirectory
        }
        
        let fm = FileManager.default
        do {
            Utils.userDataDirectory = try fm.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return Utils.userDataDirectory!
        } catch {
            print("\(error)")
        }
        
        fatalError()
    }
    
    static func createCompleteDirectoryHierarchyIfDoesNotExist(_ url: URL) -> Bool {
        let path = url.path
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        }
        return true
    }
}
