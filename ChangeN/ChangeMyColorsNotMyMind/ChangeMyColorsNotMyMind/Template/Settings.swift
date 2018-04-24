//
//  Settings.swift
//  ChangeMyColorsNotMyMind
//
//  Created by Alumnoids on 24/04/18.
//  Copyright © 2018 Jorge Guadarrama. All rights reserved.
//

import SpriteKit

// Always declared as UInt32
// Avoid creating instances of my type
enum PhysicsCategories {
 // Type properties
    static let none:UInt32 = 0
    // Physics categories in SpriteKit are always declared as UInt32. Unsigned 32 bit int
    // We don't need any physical simulation to take place
    
    // Different way to write 1
    static let ballCategory: UInt32 = 0x1 // 01
    
    //bitwise shift operator
    static let switchCategory: UInt32 = 0x1 << 1 //10
    // Shift all my bits
    // This prepares my masks to compare each digit
    
}

enum ZPositions {
    
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}


