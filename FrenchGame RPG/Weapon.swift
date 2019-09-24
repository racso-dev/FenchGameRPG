//
//  Weapon.swift
//  FrenchGame RPG
//
//  Created by Oscar RENIER on 16/07/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import Foundation

class Weapon {
    let damage : Int

    init(damage: Int) {
        self.damage = damage
    }

    init() {
        self.damage = Int.random(in: 1...30)
    }
}
