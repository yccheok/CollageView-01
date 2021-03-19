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
    let names = ["0.jpg","1.jpg","2.jpg","3.jpg","4.jpg"]
    
    @IBAction func set(_ sender: Any) {
        var attachments: [Attachment] = []
        
        for i in (0...4).reversed() {
            let image = UIImage(named: Utils.getAttachmentPath(Directory.Default, names[i]).path)!
            
            let attachment = Attachment(
                directory: Directory.Default,
                name: names[i],
                width: (Double)(image.size.width),
                height: (Double)(image.size.height)
            )
            
            attachments.append(attachment)
        }
        
        collageView.setAttachments(attachments)
        scrollableCollageView.setAttachments(attachments)
    }
    
    @IBAction func add(_ sender: Any) {
        let image = UIImage(named: Utils.getAttachmentPath(Directory.Default, names[index]).path)!
        
        let attachment = Attachment(
            directory: Directory.Default,
            name: names[index],
            width: (Double)(image.size.width),
            height: (Double)(image.size.height)
        )
        
        collageView.addAttachment(attachment)
        scrollableCollageView.addAttachment(attachment)
        
        index = (index + 1) % names.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

