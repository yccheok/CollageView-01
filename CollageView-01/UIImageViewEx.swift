//
//  UIImageViewEx.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 15/03/2021.
//

import Foundation
import UIKit

class UIImageViewEx : UIImageView {

    var intrinsicSize: CGSize = .init(width: 0, height: 0) {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return self.intrinsicSize
    }
}
