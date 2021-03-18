//
//  CollageView.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 15/03/2021.
//

import UIKit

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
            _ = _addAttachment(attachment)
        }
        
        // self.horizontalStackViews is ready. Let's perform scaling.
        for row in 0..<horizontalStackViews.count {
            scaleRow(row)
        }
    }
    
    func addAttachment(_ attachment: Attachment) {
        let result = _addAttachment(attachment)
        if !result {
            return
        }
        scaleRow(horizontalStackViews.count-1)
    }

    func _addAttachment(_ attachment: Attachment) -> Bool {
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
            horizontalStackView.distribution = .fillProportionally
            horizontalStackView.alignment = .top
            horizontalStackView.spacing = spacing
            
            self.horizontalStackViews.append(horizontalStackView)
            self.verticalStackView.addArrangedSubview(horizontalStackView)
        }
        
        return true
    }
    
    private func scaleRow(_ row: Int) {
        let startIndex = row*self.countPerRow
        let endIndex = min(startIndex+self.countPerRow, self.attachments.count)-1
        
        var basedWidth: Double = 0
        var basedHeight: Double = Double.greatestFiniteMagnitude
        
        // Searching for based size.
        for index in startIndex...endIndex {
            let attachment = self.attachments[index]
            if attachment.height < basedHeight {
                basedWidth = attachment.width
                basedHeight = attachment.height
            }
        }
        
        var weights : [Double] = []
        var totalWeight: Double = 0.0
        
        // Building weights.
        for index in startIndex...endIndex {
            let attachment = self.attachments[index]
            let weight = (attachment.width / basedWidth) * (basedHeight / attachment.height)
            weights.append(weight)
            totalWeight = totalWeight + weight
        }
        
        let horizontalStackView = horizontalStackViews[row]
        
        for index in (0..<horizontalStackView.subviews.count).reversed() {
            let subview = horizontalStackView.subviews[index]
            horizontalStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        for index in startIndex...endIndex {
            let attachment = self.attachments[index]
            let weight = weights[index-startIndex]
            let newWidth = (weight/totalWeight) * (Double)(self.frame.width - self.spacing*CGFloat(endIndex-startIndex))
            let oldWidth = attachment.width
            let oldHeight = attachment.height
            let newHeight = newWidth / oldWidth * oldHeight
            
            let imageView = UIImageViewEx()
            imageView.contentMode = .scaleAspectFit
            imageView.intrinsicSize = CGSize(width: newWidth, height: newHeight)

            // TODO: Use async way to load image.
            imageView.image = UIImage(named: attachment.name)!
            
            horizontalStackView.addArrangedSubview(imageView)
            
            self.imageViews.append(imageView)
        }
    }
}
