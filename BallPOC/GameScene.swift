//
//  GameScene.swift
//  BallPOC
//
//  Created by Gayathri on 27/04/16.
//  Copyright (c) 2016 Gayathri_b. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
    var i = 0
   let sceneCategory: UInt32 = 0x1 << 2
   let ballCategory: UInt32 = 0x1 << 1
  
  override func didMoveToView(view: SKView) {
      
     let physicsbody = SKPhysicsBody (edgeLoopFromRect: self.frame)
      physicsbody.friction = 0
      physicsbody.angularDamping = 0
      physicsbody.linearDamping = 0
      physicsbody.allowsRotation = false
      physicsbody.restitution = 1.0
      physicsBody!.categoryBitMask = sceneCategory
      // we set the body defining the physics to our scene
      self.physicsBody = physicsbody
      addBallsToScene()
    }
  func addBallsToScene(){
    
    self.physicsWorld.gravity = CGVectorMake(0, 0)
    let shape = SKShapeNode(circleOfRadius:50)
    // we set the color and line style
    shape.name = "Ball\(i)"
    print(shape.name)
    shape.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
    shape.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
    shape.lineWidth = 1
    // we create a text node to embed text in our ball
    let text = SKLabelNode(text: "Tap to Hold")
    // we set the font
    text.fontSize = 15.0
    text.fontName = "Chalkduster"
    text.userInteractionEnabled = false
    // we nest the text label in our ball
    shape.addChild(text)
    shape.position = CGPointMake(size.width/2, size.height/2)
    addChild(shape)
    shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
    // this defines the mass, roughness and bounciness
    shape.physicsBody!.friction = 0
    shape.physicsBody!.restitution = 1
    shape.physicsBody?.linearDamping = 0
    shape.physicsBody?.angularDamping = 0
    shape.physicsBody!.mass = 0.03
    shape.physicsBody!.dynamic = true
    shape.physicsBody!.categoryBitMask = ballCategory
 
    shape.physicsBody!.collisionBitMask = sceneCategory
    
    shape.physicsBody!.affectedByGravity = false
    // this will allow the balls to rotate when bouncing off each other
    shape.physicsBody!.allowsRotation = false
    shape.physicsBody!.applyImpulse(CGVectorMake(20, -20))
    i+=1
  }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
          let location = touch.locationInNode(self)
          let touchedNode = self.nodeAtPoint(location)
          
          if let name = touchedNode.name
          {
            if name.containsString("Ball")
            {
             print("Touched \(name)")
             touchedNode.physicsBody?.dynamic = false
             if (i < 4)
             {addBallsToScene()}
            }
            else{
              print("Not Touched")
            }
          }

          
        }
    }
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch: AnyObject in touches {
      let location = (touch as! UITouch).locationInNode(self)
      let touchedNode = self.nodeAtPoint(location)
      print("Untouched\(touchedNode.name)")
      touchedNode.physicsBody?.dynamic = true
      touchedNode.physicsBody?.applyImpulse(CGVectorMake(20, -20))
    }
    
  }
  
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
