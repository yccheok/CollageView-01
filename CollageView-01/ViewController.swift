//
//  ViewController.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 15/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collageView: CollageView!
    @IBOutlet var scrollableCollageView: ScrollableCollageView!
    var index: Int = 0
    
    @IBAction func set(_ sender: Any) {
        var attachments: [Attachment] = []
        
        for i in (0...4).reversed() {
            let image = UIImage(named: String(i))!
            
            let attachment = Attachment(name: String(i), width: (Double)(image.size.width), height: (Double)(image.size.height))
            
            attachments.append(attachment)
        }
        
        collageView.setAttachments(attachments)
        scrollableCollageView.setAttachments(attachments)
    }
    
    @IBAction func add(_ sender: Any) {
        let image = UIImage(named: String(index))!
        
        let attachment = Attachment(name: String(index), width: (Double)(image.size.width), height: (Double)(image.size.height))
        
        collageView.addAttachment(attachment)
        scrollableCollageView.addAttachment(attachment)
        
        index = index + 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

