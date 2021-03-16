//
//  CollageView.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 15/03/2021.
//

import UIKit

class CollageView: UIView {
    
    @IBOutlet var verticalStackView: UIStackView!
    
    let spacing = CGFloat(1)
    
    var attachments: [Attachment] = []
    var attachmentSet = Set<Attachment>()
    let countPerRow = 3;
    var rows: [UIStackView] = []
    
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
    }

    func commonInit() {
        let view = instanceFromNib()
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func addAttachment(_ attachment: Attachment) {
        let result = _addAttachment(attachment)
        if !result {
            return
        }
        scaleRow(rows.count-1)
    }

    func _addAttachment(_ attachment: Attachment) -> Bool {
        if !attachmentSet.insert(attachment).inserted {
            return false
        }
        
        attachments.append(attachment)
        
        let count = attachments.count
        let row = (count-1) / countPerRow;
        
        // Do we need to add new row?
        if (rows.count <= row) {
            let horizontalStackView = UIStackView()
            
            horizontalStackView.axis = .horizontal
            horizontalStackView.distribution = .fillProportionally
            horizontalStackView.alignment = .top
            horizontalStackView.spacing = spacing
            
            rows.append(horizontalStackView)
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
        
        return true
    }
    
    private func scaleRow(_ row: Int) {
        let startIndex = row*countPerRow
        let endIndex = min(startIndex+countPerRow, attachments.count)-1
        
        var basedWidth: Double = 0
        var basedHeight: Double = Double.greatestFiniteMagnitude
        
        // Searching for based size.
        for index in startIndex...endIndex {
            let attachment = attachments[index]
            if attachment.height < basedHeight {
                basedWidth = attachment.width
                basedHeight = attachment.height
            }
        }
        
        var weights : [Double] = []
        var totalWeight: Double = 0.0
        
        // Building weights.
        for index in startIndex...endIndex {
            let attachment = attachments[index]
            let weight = (attachment.width / basedWidth) * (basedHeight / attachment.height)
            weights.append(weight)
            totalWeight = totalWeight + weight
        }
        
        let horizontalStackView = rows[row]
        
        for index in (0..<horizontalStackView.subviews.count).reversed() {
            let subview = horizontalStackView.subviews[index]
            horizontalStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        for index in startIndex...endIndex {
            let attachment = attachments[index]
            let weight = weights[index-startIndex]
            let newWidth = (weight/totalWeight) * (Double)(self.frame.width - spacing*CGFloat(endIndex-startIndex))
            let oldWidth = attachment.width
            let oldHeight = attachment.height
            let newHeight = newWidth / oldWidth * oldHeight
            
            let imageView = UIImageViewEx()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: attachment.name)!
            imageView.intrinsicSize = CGSize(width: newWidth, height: newHeight)

            print("\(attachment.name) -> \(imageView.intrinsicSize)")
            horizontalStackView.addArrangedSubview(imageView)
        }
    }
}
