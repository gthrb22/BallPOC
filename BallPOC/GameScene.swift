//
//  GameScene.swift
//  BallPOC
//
//  Created by Gayathri on 27/04/16.
//  Copyright (c) 2016 Gayathri_b. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  
  let sceneCategory: UInt32 = 0x1 << 2
  let ballCategory: UInt32 = 0x1 << 1
  let freeBallCategory: UInt32 = 0x1 << 3
  let explosionSound = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
  var gameOver = false
  var freeBallCount = 0
  let appDelegate = UIApplication.sharedApplication().delegate  as! AppDelegate
  var touchedTapToHoldBall = 0
  override init(size: CGSize) {
    super.init(size: size)
    let physicsbody1 = SKPhysicsBody (edgeLoopFromRect: self.frame)
    physicsbody1.friction = 0
    physicsbody1.angularDamping = 0
    physicsbody1.linearDamping = 0
    physicsbody1.allowsRotation = false
    physicsbody1.restitution = 1.0
    physicsbody1.categoryBitMask = sceneCategory
    // we set the body defining the physics to our scene
    self.physicsBody = physicsbody1
    addTapToHoldBalls(appDelegate.levelCompletion + 1)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func addTapToHoldBalls(ballstoAdd:Int){
   
    self.physicsWorld.gravity = CGVectorMake(0, 0)
    for i in 0..<ballstoAdd {
    let shape = SKShapeNode(circleOfRadius:40)
    // we set the color and line style
    shape.name = "Hold\(i)"
    print(shape.name)
    shape.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
    shape.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
    shape.lineWidth = 1
    // we create a text node to embed text in our ball
    let text = SKLabelNode(text: "Tap to Hold")
    // we set the font
    text.fontSize = 10.0
    text.fontName = "Chalkduster"
    text.userInteractionEnabled = false
    // we nest the text label in our ball
    shape.addChild(text)
    shape.position = randomPointWithContainerSize(self.size, viewSize: shape.frame.size)
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
    shape.physicsBody!.usesPreciseCollisionDetection = true
    shape.physicsBody!.affectedByGravity = false
    // this will allow the balls to rotate when bouncing off each other
    shape.physicsBody!.allowsRotation = false
    shape.physicsBody!.applyImpulse(CGVectorMake(20, -20))
   
    }
    print(self.children.count)
  }
  func randomPointWithContainerSize(size:CGSize,viewSize:CGSize)->CGPoint{
    let xRange = size.width - viewSize.width
    let yRange = size.height - viewSize.height
    let minX = (size.width - xRange)/2
    let minY = (size.height - yRange)/2
    let randomX = (Int(arc4random()) % Int(floorf(Float(xRange)))) + Int(minX)
    let randomY = (Int(arc4random()) % Int(floorf(Float(yRange)))) + Int(minY)
    return CGPointMake(CGFloat(randomX), CGFloat(randomY))
  }
  func endGame(completedLevel:String) {
   
    gameOver = true
  
    removeAllChildren()
    removeAllActions()
    runAction(explosionSound)
   
    let reveal = SKTransition.flipHorizontalWithDuration(0.5)
    let gameOverScene = GameOverScene(size: self.size, completedLevel:completedLevel)
    self.view?.presentScene(gameOverScene, transition: reveal)
  

  }
  override func update(currentTime: CFTimeInterval) {
    //1
    if !gameOver {
  
      switch appDelegate.levelCompletion {
      case 0:
        if (freeBallCount>1 && freeBallCount == 17) {
          endGame("Level 1 Completed :)")
          appDelegate.levelCompletion = 1        }
      
      case 1 :
       if (freeBallCount>1 && freeBallCount == 17) {
          endGame("Level 2 Completed :)")
          appDelegate.levelCompletion = 2
        }
      case 2 :
        if (freeBallCount>1 && freeBallCount == 17) {
          endGame("Level 3 Completed :)")
          appDelegate.levelCompletion = 3
        }
      case 3 :
        if (freeBallCount>1 && freeBallCount == 17) {
          endGame("Level 4 Completed :)")
          appDelegate.levelCompletion = 4
        }
        
      default:
        break
        
      }
    }
    else{
      
  }
  }
  func addFreeBalls(){
    for _ in 0...45{
      let shape = SKShapeNode(circleOfRadius:30)
      // we set the color and line style
      shape.name = "Free"
      print(shape.name)
      shape.fillColor = UIColor(red: 0, green: 0, blue: 255, alpha: 0.5)
      shape.strokeColor = UIColor(red: 0, green: 0, blue: 255, alpha: 0.5)
      shape.lineWidth = 1
    
      // Position the monster slightly off-screen along the right edge,
      // and along a random position along the Y axis as calculated above
      shape.position = randomPointWithContainerSize(self.size, viewSize: shape.frame.size)
      
      addChild(shape)
      freeBallCount+=1
      shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
      // this defines the mass, roughness and bounciness
      shape.physicsBody!.friction = 0
      shape.physicsBody!.restitution = 1
      shape.physicsBody?.linearDamping = 0
      shape.physicsBody?.angularDamping = 0
      shape.physicsBody!.mass = 0.03
      shape.physicsBody!.dynamic = true
      shape.physicsBody!.categoryBitMask = freeBallCategory
      shape.physicsBody!.collisionBitMask = sceneCategory|ballCategory
      shape.physicsBody!.usesPreciseCollisionDetection = true
      shape.physicsBody!.affectedByGravity = false
      // this will allow the balls to rotate when bouncing off each other
      shape.physicsBody!.allowsRotation = false
      shape.physicsBody!.applyImpulse(CGVectorMake(20, -20))
      
    }
  }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
      
        for touch in touches {
          let location = touch.locationInNode(self)
          let touchedNode = self.nodeAtPoint(location)
          
          if let name = touchedNode.name
          {
            if name.containsString("Hold")
            {
              touchedTapToHoldBall+=1
              print("Touched Hold \(name)")
              touchedNode.physicsBody?.dynamic = false
              if (touchedTapToHoldBall == appDelegate.levelCompletion+1){
               addFreeBalls()
              }
            }
            else if name.containsString("Free"){
              print("Touched Free\(name)")
              touchedNode.runAction(explosionSound)
              touchedNode.removeFromParent()
              freeBallCount-=1
            }
          }

          
        }
    }
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch: AnyObject in touches {
      let location = (touch as! UITouch).locationInNode(self)
      let touchedNode = self.nodeAtPoint(location)
      print("Untouched\(touchedNode.name)")
      if (touchedNode.name?.containsString("Hold") == true){
      endGame("Sorry :( Game Over")
      touchedNode.physicsBody?.dynamic = true
      touchedNode.physicsBody?.applyImpulse(CGVectorMake(20, -20))
      }
    }
    
  }
  
    
}
