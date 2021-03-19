//
//  UIImageView+Extensions.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 19/03/2021.
//

import Foundation
import UIKit
import Nuke

extension UIImageView {
    func load(_ url: URL) {
        Nuke.loadImage(with: url, into: self)
    }
}

