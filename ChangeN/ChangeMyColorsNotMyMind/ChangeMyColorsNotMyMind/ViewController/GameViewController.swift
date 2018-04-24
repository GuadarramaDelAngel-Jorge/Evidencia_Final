//
//  GameViewController.swift
//  ChangeMyColorsNotMyMind
//
//  Created by Alumnoids on 24/04/18.
//  Copyright © 2018 Jorge Guadarrama. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            // Start with the MenuScene
            let scene = MenuScene(size: view.bounds.size)
            //let scene2 = GameScene(size: view.bounds.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
             //   scene2.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

}
