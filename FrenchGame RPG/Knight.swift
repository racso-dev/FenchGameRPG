//
//  Knight.swift
//  FrenchGame RPG
//
//  Created by Oscar RENIER on 12/07/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import Foundation

class Knight : Hero {

    init() {
        super.init(health: 200, weapon: Weapon(damage: 10), type: "Knight")
    }

}
