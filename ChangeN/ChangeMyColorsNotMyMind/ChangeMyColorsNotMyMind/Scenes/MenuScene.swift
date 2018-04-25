//
//  MenuScene.swift
//  ChangeMyColorsNotMyMind
//
//  Created by Alumnoids on 24/04/18.
//  Copyright © 2018 Jorge Guadarrama. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView){
        
        backgroundColor = UIColor(red: 20/255, green: 60/255, blue: 70/255, alpha: 1.0)
        addLogo()
        addLabels()
    }
    
    func addLogo(){
        
        let logo = SKSpriteNode(imageNamed: "ownwheel1")
        logo.size = CGSize(width: frame.width/2, height: frame.width/2)
        // Slightly above the y axis
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
        
    }
    
    func addLabels(){
        
        let playLabel = SKLabelNode(text:"Tap to start Playing!")
        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 40.0
        playLabel.fontColor = UIColor.white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        animate(label: playLabel)
        
        let highscoreLabel = SKLabelNode(text:"Highscore:" + "\(UserDefaults.standard.integer(forKey: "Highscore"))")
        highscoreLabel.fontName = "AvenirNext-Bold"
        highscoreLabel.fontSize = 35.0
        highscoreLabel.fontColor = UIColor.white
        highscoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highscoreLabel.frame.size.height*4)
        addChild(highscoreLabel)
        
        
        let recentScoreLabel = SKLabelNode(text: "Recent Score:" + "\(UserDefaults.standard.integer(forKey: "RecentScore"))")
        recentScoreLabel.fontName = "AvenirNext-Bold"
        recentScoreLabel.fontSize = 35.0
        recentScoreLabel.fontColor = UIColor.white
        recentScoreLabel.position = CGPoint(x: frame.midX, y: highscoreLabel.position.y - recentScoreLabel.frame.size.height*2)
        addChild(recentScoreLabel)
        
    }
    
    func animate(label: SKLabelNode){
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let sequence = SKAction.sequence([fadeOut,fadeIn])
        label.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        let gameScene = GameScene(size:view!.bounds.size)
        view!.presentScene(gameScene)
        
    }
}

