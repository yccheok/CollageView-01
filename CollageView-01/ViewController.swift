//
//  ViewController.swift
//  CollageView-01
//
//  Created by Cheok Yan Cheng on 15/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collageView: CollageView!
    var index: Int = 0
    
    @IBAction func click(_ sender: Any) {
        let image = UIImage(named: String(index))!
        
        let attachment = Attachment(name: String(index), width: (Double)(image.size.width), height: (Double)(image.size.height))
        
        collageView.addAttachment(attachment)
        
        index = index + 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

