//
//  GameScene.swift
//  ChangeMyColorsNotMyMind
//
//  Created by Alumnoids on 24/04/18.
//  Copyright © 2018 Jorge Guadarrama. All rights reserved.
//

import SpriteKit

enum PlayColors {
    
    static let colors = [/*UIColor(red: 235/255, green: 28/255, blue: 34/255, alpha: 1.0),
                         UIColor(red: 254/255, green: 242/255, blue: 0/255, alpha: 1.0),
                         UIColor(red: 63/255, green: 71/255, blue: 204/255, alpha: 1.0),
                         UIColor(red: 35/255, green: 177/255, blue: 77/255, alpha: 1.0)*/
         UIColor(red: 235/255, green: 28/255, blue: 34/255, alpha: 1.0),
         UIColor(red: 254/255, green: 242/255, blue: 0/255, alpha: 1.0),
         UIColor(red: 35/255, green: 177/255, blue: 77/255, alpha: 1.0),
         UIColor(red: 0/255, green: 163/255, blue: 232/255, alpha: 1.0)
        
    ]
}

enum SwitchState: Int{
    
    case red, yellow, green, blue
}

class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    // Defining an initial state to the image 
    // Red upwards
    var switchState = SwitchState.red
    // Optional
    var currentColorIndex:Int?
    
    // For the menu
    let scoreLabel = SKLabelNode(text:"0")
    var score = 0
    
    override func didMove(to view: SKView) {
        
        setupPhysics()
        layoutScene()
    }
    
    // Possible way to change difficulty
    //Change gravitiy
    func setupPhysics(){
        
        // We could setup the value of Earth's gravity but it's way too big for a value and for its playability
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.5)
        // Register the ocurring physics contact
        physicsWorld.contactDelegate = self
    }
    
    // Changing the gravity to -1.0
    func setupChangePhysics(){
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        physicsWorld.contactDelegate = self
        
    }
    
    // Changing the gravity again 
    func setupChangePhysicsAgain(){
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
        colorSwitch = SKSpriteNode(imageNamed: "8colorwheelfinal")
       
    }
    
    func layoutScene(){
        backgroundColor = UIColor(red: 20/255, green: 60/255, blue: 70/255, alpha: 1.0)
        
        colorSwitch = SKSpriteNode(imageNamed: "ownwheel1")
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        // In order to avoid letting the colorSwitch stick to the bottom
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.zPosition = ZPositions.colorSwitch
        // Defining physics
        // This mirrors the shape of the colorSwitch image
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius:colorSwitch.size.width/2)
        // Defining the category of the mask
        // UInt32
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        // Stops its physicsbody in order to avoid get affected by other forces
        colorSwitch.physicsBody?.isDynamic = false
        // Pass the node
        addChild(colorSwitch)
        
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = ZPositions.label
        addChild(scoreLabel)
        
        spawnBall()
    }
    
    func updateScoreLabel() {
        
        scoreLabel.text = "\(score)"
        
    }
    
    func spawnBall(){
        // The way to define a random int between 0 and 3
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        // Texture (normal image), color and size
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "Ball"), color: PlayColors.colors[currentColorIndex!], size:CGSize(width: 30.0, height: 30.0))
        // ball.size = CGSize(width: 30.0, height: 30.0)
        // Color applied to my texture
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        // Up
        ball.position = CGPoint(x: frame.midX, y: frame.maxY)
        ball.zPosition = ZPositions.ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        // Determines when does the ball touches the switch
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        // Determines whether items can collide with each other
        // We don't want the ball to collide but to chech their interaction
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        addChild(ball)
    }
    
    // Method to move the image by taps
    func turnColorWheel(){
        
        // Avoid nil
        if let newState = SwitchState(rawValue: switchState.rawValue+1){
            switchState = newState
        } else {
            // First case in the enum
            switchState = .red
        }
        
        // Defining the animation of the node
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
        
    }
    
    func gameOver(){
        
        UserDefaults.standard.set(score, forKey: "RecentScore")
        if score > UserDefaults.standard.integer(forKey: "Highscore"){
            
            UserDefaults.standard.set(score, forKey: "Highscore")
        }
        
        // TEST print("GameOver")
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        turnColorWheel()
    }
}

// This only implements optional methods
extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact){
        //01
        //10
        //11
        // contact has the physical bodies of the nodes
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        // React to the contact between the ball and the colorSwitch
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
            // TEST print("Collision")
            // Check the node and asign the name Ball
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                
                // Check colors
                if currentColorIndex == switchState.rawValue {
                    // print("Correct function")
                    score+=1
                    if score == 5 {
                        
                        setupChangePhysics()
                    } else if score > 15 {
                        
                        setupChangePhysicsAgain()
                    }
                    
                    updateScoreLabel()
                    // As soon as the color matches the wheel
                    ball.run(SKAction.fadeOut(withDuration: 0.05), completion: {
                        // Remove the old ball
                        ball.removeFromParent()
                        // Add new ball
                        self.spawnBall()
                    })
                }else {
                    
                    gameOver()
                    
                }
            }
            
        }
        
    }
}


