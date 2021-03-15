//
//  UIView+Extensions.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 15/03/2021.
//

import Foundation
import UIKit

extension UIView {
    func instanceFromNib() -> UIView {
        let _type = type(of: self)
        let bundle = Bundle(for: _type)
        let nib = UINib(nibName: String(describing: _type), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
}
