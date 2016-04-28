//
//  GameScene.swift
//  BallPOC
//
//  Created by Gayathri on 27/04/16.
//  Copyright (c) 2016 Gayathri_b. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var shape:SKShapeNode?
  
  override func didMoveToView(view: SKView) {
      
      let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
      physicsBody.friction = 0
      physicsBody.angularDamping = 0
      physicsBody.linearDamping = 0
      physicsBody.allowsRotation = false
      physicsBody.restitution = 1.0
      // we set the body defining the physics to our scene
      self.physicsBody = physicsBody
      
      addBallsToScene()
    }
  func addBallsToScene(){
    
    self.physicsWorld.speed = 1.0
    self.physicsWorld.gravity = CGVectorMake(0, 0)
    shape = SKShapeNode(circleOfRadius:50)
    // we set the color and line style
    shape!.name = "Ball"
    shape!.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
    shape!.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
    shape!.lineWidth = 1
    // we create a text node to embed text in our ball
    let text = SKLabelNode(text: "Tap to Hold")
    // we set the font
    text.fontSize = 15.0
    text.fontName = "Chalkduster"
    // we nest the text label in our ball
    shape!.addChild(text)
    shape!.position = CGPointMake(size.width/2, size.height/2)
    addChild(shape!)
    shape!.physicsBody = SKPhysicsBody(circleOfRadius: shape!.frame.size.width/2)
    // this defines the mass, roughness and bounciness
    shape!.physicsBody!.friction = 0
    shape!.physicsBody!.restitution = 1
    shape!.physicsBody?.linearDamping = 0
    shape!.physicsBody?.angularDamping = 0
    shape!.physicsBody!.mass = 0.03
    // this will allow the balls to rotate when bouncing off each other
    shape!.physicsBody!.allowsRotation = false
    shape!.physicsBody!.applyImpulse(CGVectorMake(10, -10))
    
  }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
          let location = touch.locationInNode(self)
          let touchedNode = self.nodeAtPoint(location)
          
          if let name = touchedNode.name
          {
            if name == "Ball"
            {
              print("Touched")
             shape?.physicsBody = nil
              
            }
            else{
              print("Not Touched")
            }
          }

          
        }
    }
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    shape!.physicsBody = SKPhysicsBody(circleOfRadius: shape!.frame.size.width/2)
    // this defines the mass, roughness and bounciness
    shape!.physicsBody!.friction = 0
    shape!.physicsBody!.restitution = 1
    shape!.physicsBody?.linearDamping = 0
    shape!.physicsBody?.angularDamping = 0
    shape!.physicsBody!.mass = 0.03
    // this will allow the balls to rotate when bouncing off each other
    shape!.physicsBody!.allowsRotation = false
    shape!.physicsBody!.applyImpulse(CGVectorMake(10, -10))
      

  }
  
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
