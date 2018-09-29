//
//  ViewController.swift
//  imageScaleIssue
//
//  Created by Hang Yu on 2018/9/29.
//  Copyright © 2018 Hang Yu. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // create an imageNode with roundingType .precomposited
        let n1 = createImageNode()
        n1.cornerRoundingType = .precomposited
        n1.cornerRadius = 2
        self.view.addSubnode(n1)
        n1.position = CGPoint(x: 200, y: 200)
        
        // create a normal imageNode
        let n2 = createImageNode()
        self.view.addSubnode(n2)
        n2.position = CGPoint(x: 200, y: 400)
        
        // the image is 640px * 360px, thus the backing store should be the same.
        // print sizes of the layer's contents, we get:
        // n1 layer size: 1920 * 1080 (wrong size)
        // n2 layer size: 640 * 360 (correct size)
        // obviously the cornerRounding set should NOT affect layer contents size
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            print("n1 layer size: \((n1.layer.contents as! CGImage).width) * \((n1.layer.contents as! CGImage).height)")
            print("n2 layer size: \((n2.layer.contents as! CGImage).width) * \((n2.layer.contents as! CGImage).height)")
        }
    }
    
    func createImageNode() -> ASImageNode {
        let node = ASImageNode()
        let image = UIImage(named: "test")!
        node.image = image
        node.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        return node
    }


}

