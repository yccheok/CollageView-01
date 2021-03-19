//
//  CollageView.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 15/03/2021.
//

import UIKit
import Nuke

class CollageView: UIView {
    
    @IBOutlet var verticalStackView: UIStackView!
    
    @IBOutlet var stackViewAndSafeAreaBottomConstraint: NSLayoutConstraint!
    
    let spacing = CGFloat(1)
    
    var imageViews: [UIImageViewEx] = []
    var attachments: [Attachment] = []
    var attachmentSet = Set<Attachment>()
    
    var horizontalStackViews: [UIStackView] = []
    let countPerRow = 3
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        let view = instanceFromNib()
        view.frame = self.bounds
        self.addSubview(view)
        
        // Default is not embed in scroll view.
        embedInScrollView(false)
    }
    
    func embedInScrollView(_ embed: Bool) {
        stackViewAndSafeAreaBottomConstraint.isActive = embed
    }
    
    func setAttachments(_ attachments: [Attachment]) {
        self.attachmentSet.removeAll()
        self.attachments.removeAll()
        self.horizontalStackViews.removeAll()
        self.imageViews.removeAll()
        
        self.verticalStackView.removeAllView()

        for attachment in attachments {
            _ = addAttachment(attachment)
        }
    }

    func replace(_ index: Int, _ attachment: Attachment) {
        let imageView = imageViews[index]
        let oldAttachment = attachments[index]
        attachments[index] = attachment

        precondition(oldAttachment.isSameSize(attachment))

        attachmentSet.remove(oldAttachment)
        attachmentSet.insert(attachment)

        imageView.load(attachment.getPath())
    }
    
    func addAttachment(_ attachment: Attachment) -> Bool {
        if !self.attachmentSet.insert(attachment).inserted {
            return false
        }
        
        self.attachments.append(attachment)
        
        let count = self.attachments.count
        let row = (count-1) / self.countPerRow;
        
        // Do we need to add new row?
        if (self.horizontalStackViews.count <= row) {
            let horizontalStackView = UIStackView()
            
            horizontalStackView.axis = .horizontal
            horizontalStackView.distribution = .fill
            horizontalStackView.alignment = .fill
            horizontalStackView.spacing = spacing
            
            self.horizontalStackViews.append(horizontalStackView)
            self.verticalStackView.addArrangedSubview(horizontalStackView)
        }
        
        let imageView = UIImageViewEx()
        imageView.contentMode = .scaleAspectFit

        imageView.load(attachment.getPath())
        
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: CGFloat(attachment.height / attachment.width)).isActive = true
        
        self.horizontalStackViews[row].addArrangedSubview(imageView)
        
        self.imageViews.append(imageView)
        
        return true
    }
}
