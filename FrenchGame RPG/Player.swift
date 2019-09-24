//
//  Player.swift
//  FrenchGame RPG
//
//  Created by Oscar RENIER on 10/07/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import Foundation

class Player {

    let id : Int
    let name : String
    var team = [Hero]()

    init(id: Int) {
        self.id = id
        self.name = "Player " + String(id)
    }

    ///Method that add a given hero to the player's team
    func addTeamHero(hero: Hero) {
        self.team.append(hero)
    }

    ///Method that displays a given team with all associated heroes infos
    private func displayGivenTeam(team: [Hero]) {
        var i = 1

        for hero in team {
            if hero.health > 0 {
                print("\(i). \(hero.type)                 ", terminator: "")
                hero.displayHeroInfo(all: false)
            }
            i += 1
        }
        print("\n")
    }

    ///Method that asks the user to select a hero of his team to interract during the ongoing turn
    private func chooseHeroToInteract(team: [Hero]) -> Hero {
        displayGivenTeam(team: team)
        if let choice = readLine() {
            if let choiceNbr = Int(choice) {
                return team[choiceNbr - 1]
            }
        }
        return team[0]
    }

    ///Method that asks the user to select a hero of the opponent team to attack
    private func chooseHeroToAttack(team: [Hero]) -> Hero {
        displayGivenTeam(team: team)
        print("Please choose a hero to attack :")
        if let choice = readLine() {
            if let choiceNbr = Int(choice) {
                return team[choiceNbr - 1]
            }
        }
        return team[0]
    }

    ///Method that represents the sequence of a turn
    func playHisTurn(ownTeam: [Hero], enemyTeam: [Hero], choseToAttack: Bool) {
        print("\nPlease choose a hero of your team:")
        let ownHero = chooseHeroToInteract(team: ownTeam)
        if choseToAttack {
            print("\n")
            let enemyHero = chooseHeroToAttack(team: enemyTeam)
            ownHero.attacks(target: enemyHero)
        } else {
            print("Please choose your healer :")
            let healer = chooseHeroToInteract(team: ownTeam)
            healer.heals(target: ownHero)

        }
    }

    ///Method that displays all the team infos by calling hero.displayHeroInfo
    func displayTeamInfo(team: [Hero]) {
        for hero in team {
            hero.displayHeroInfo(all: true)
        }
    }

    ///Method that tells if this player has lost by calling hero.isHeroDead() to all elements of team
    func hasLost() -> Bool {
        for hero in team {
            if !hero.isHeroDead() {
                return false
            }
        }
        return true
    }
}
