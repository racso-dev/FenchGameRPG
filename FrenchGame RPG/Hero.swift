//
//  Hero.swift
//  FrenchGame RPG
//
//  Created by Oscar RENIER on 10/07/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import Foundation

class Hero {

    let type : String
    var name : String?
    var health : Int
    var weapon : Weapon

    init(health: Int, weapon: Weapon, type: String) {
        self.health = health
        self.weapon = weapon
        self.type = type
    }

    ///Performs the attack to a given target
    func attacks(target: Hero) {
        target.health -= self.weapon.damage
    }

    ///Performs a heal to a given target which is supposed to be in the same team
    func heals(target: Hero) {
        target.health += self.weapon.damage
    }

    ///Method that is called to display the hero's current informations
    ///- Parameter all: Flag to say whether to omit the type or show all properties
    func displayHeroInfo(all: Bool) {
        if all {
            print("Type: \(self.type)        Name: \(self.name!)               Health: \(self.health)      Damages: \(weapon.damage)")
        } else {
            print("Name: \(self.name!) Health: \(self.health) Damages: \(weapon.damage)")
        }
    }

    ///Method that tells if this hero is dead or not
    func isHeroDead() -> Bool {
        if self.health <= 0 {
            return true
        }
        return false
    }
}
