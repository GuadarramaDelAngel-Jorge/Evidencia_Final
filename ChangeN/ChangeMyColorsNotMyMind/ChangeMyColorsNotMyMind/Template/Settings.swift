//
//  Settings.swift
//  ChangeMyColorsNotMyMind
//
//  Created by Alumnoids on 24/04/18.
//  Copyright © 2018 Jorge Guadarrama. All rights reserved.
//

import SpriteKit

// Always declared as UInt32
enum PhysicsCategories {
    
    static let none:UInt32 = 0
    static let ballCategory: UInt32 = 0x1 // 1
    
    //bitwise shift operator
    static let switchCategory: UInt32 = 0x1 << 1 //10
    // Shift all my bits
    
}

enum ZPositions {
    
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}


