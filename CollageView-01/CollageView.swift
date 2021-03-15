//
//  CollageView.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 15/03/2021.
//

import UIKit

class CollageView: UIView {
    
    @IBOutlet var verticalStackView: UIStackView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        print("verticalStackView -> \(verticalStackView)")
    }

    func commonInit() {
        let view = instanceFromNib()
        view.frame = self.bounds
        self.addSubview(view)
    }
}
