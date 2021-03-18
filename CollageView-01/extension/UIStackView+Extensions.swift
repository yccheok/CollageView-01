//
//  UIStackView+Extensions.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 18/03/2021.
//

import Foundation
import UIKit

extension UIStackView {
    func removeView(_ index: Int) {
        let arrangedSubview = self.arrangedSubviews[index]
        self.removeArrangedSubview(arrangedSubview)
        arrangedSubview.removeFromSuperview()
    }
    
    func removeAllView() {
        // It is safer to remove from backward.
        for (_, arrangedSubview) in self.arrangedSubviews.enumerated().reversed() {
            self.removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
    }
}
