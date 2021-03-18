//
//  ScrollableCollageView.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 17/03/2021.
//

import UIKit

class ScrollableCollageView: UIView {
    @IBOutlet var collageView: CollageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        let view = instanceFromNib()
        view.frame = self.bounds
        self.addSubview(view)
        
        collageView.embedInScrollView(true)
    }
    
    func addAttachment(_ attachment: Attachment) {
        collageView.addAttachment(attachment)
    }
    
    func setAttachments(_ attachments: [Attachment]) {
        collageView.setAttachments(attachments)
    }
}
