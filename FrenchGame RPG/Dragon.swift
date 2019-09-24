//
//  Dragon.swift
//  FrenchGame RPG
//
//  Created by Oscar RENIER on 12/07/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import Foundation

class Dragon : Hero {

    init() {
        super.init(health: 50, weapon: Weapon(damage: 500), type: "Dragon")
    }

}
