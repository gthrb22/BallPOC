//
//  GameViewController.swift
//  BallPOC
//
//  Created by Gayathri on 27/04/16.
//  Copyright (c) 2016 Gayathri_b. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

  override func viewWillLayoutSubviews() {
    super.viewDidLoad()
    
    let skView = self.view as! SKView
    if skView.scene == nil {
      
      let scene = GameScene(size:skView.frame.size)
      skView.showsFPS = true
      skView.showsNodeCount = true
      skView.showsPhysics = true
      skView.ignoresSiblingOrder = true
      scene.scaleMode = .AspectFill
      skView.presentScene(scene)
      
    }
  }


    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
