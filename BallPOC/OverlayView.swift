//
//  OverlayView.swift
//  BallPOC
//
//  Created by Abi's on 03/07/16.
//  Copyright © 2016 Gayathri_b. All rights reserved.
//

import UIKit

class OverlayView: UIView {

    @IBOutlet weak var levelCompletionlbl: UILabel!
    @IBOutlet weak var scorelbl: UILabel!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
      super.init(frame: frame)
        setUpOverLay()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    func setUpOverLay(){
        let bundle = NSBundle.mainBundle()
        let nib = UINib(nibName: "OverlayView",bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! OverlayView
        addSubview(view)
        
    }
}
