//
//  main.swift
//  FrenchGame RPG
//
//  Created by Oscar RENIER on 10/07/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import Foundation

class Game {

    var players = [Player]()
    var whoIsPlaying : Int
    var characterTypes : [Hero] = [Dragon(), Knight(), Healer()]
    private var characterNames : [String] = []

    init() {
        whoIsPlaying = 1
        players.append(Player(id: 1))
        players.append(Player(id: 2))
    }

    ///Method called to start the game with two calls to displayTeamComposeGameMenu() and
    ///a call to gameLoop() that starts the fight
    func start() {
        print("Welcome to FrenchGame RPG, the first RPG Made in France !")
        for _ in 0...1 {
            displayTeamComposeGameMenu()
            whoIsPlaying = switchPlayer(whoIsPlaying: whoIsPlaying)
            restoreArrayOfCharacter()
        }
        gameLoop()
    }

    ///Method that contains all the sequence of a turn
    private func gameLoop() {
        var i = 1

        while !isGameEnded(turn: i) {

            print("\n" + players[whoIsPlaying - 1].name + "'s turn :\nTurn number \(i)\n")

            let choice = displayTargetingMenu()
            let playingPlayer = whoIsPlaying(whoIsPlaying: whoIsPlaying, players: players)
            let notPlaying = whoIsNotPlaying(whoIsPlaying: whoIsPlaying, players: players)

            isPlayingPlayerLucky(player: playingPlayer, turn: i)
            playingPlayer.playHisTurn(ownTeam: playingPlayer.team, enemyTeam: notPlaying.team, choseToAttack: choice == 1)

            whoIsPlaying = switchPlayer(whoIsPlaying: whoIsPlaying)
            i += 1
        }

        print("The game is over !")
        
    }

    ///Private method called from gameLoop() to determine if a random hero of the playing player has been lucky/not and got a new weapon
    private func isPlayingPlayerLucky(player: Player, turn: Int) {
        let spawningChances = Int.random(in: turn...100)
        let randomizedHero = Int.random(in: 0...2)

        if spawningChances > 65 {
            player.team[randomizedHero].weapon = Weapon()
            print("\nYour \(player.team[randomizedHero].type) just got lucky an is now fighting with a brand new weapon with \(player.team[randomizedHero].weapon.damage) damages !\n")
        }
    }

    ///Private method that takes an Int and returns the playing player
    private func whoIsPlaying(whoIsPlaying: Int, players: [Player]) -> Player {
        if whoIsPlaying == 1 {
            return players[0]
        }
        return players[1]
    }

    ///Private method that takes an Int and returns the not playing player
    private func whoIsNotPlaying(whoIsPlaying: Int, players: [Player]) -> Player {
        if whoIsPlaying == 1 {
            return players[1]
        }
        return players[0]
    }

    ///Private method called at the end of a turn that switch the playing player to 1 or 2
    private func switchPlayer(whoIsPlaying: Int) -> Int {
        switch whoIsPlaying {
        case 2:
            return 1
        default:
            return 2
        }
    }

    ///Private method that displays to the playing player the choice between attacking and healing
    private func displayTargetingMenu() -> Int {
        print("1. Attack a hero")
        print("2. Heal a hero\n")

        if let choice = readLine() {
            if let choiceNbr = Int(choice) {
                return choiceNbr
            } else {
                print("\nWrong input, please retry !")
            }
        } else {
            print("\nWrong input, please retry !")
        }
        return 1
    }

    ///Private method that is called when the user has to compose his team, to display the avaible heros.
    ///Countdown is serving displaying purposes
    private func displayAvailableCharacterTypes(countdown: Int) { /// Ser

        for i in 1...countdown {
            print("\(i). \(characterTypes[i - 1].type)")
        }
    }

    ///Private method that is called after a player finished to compose his team
    ///to allow another player to compose his team
    private func restoreArrayOfCharacter() {
        characterTypes = [Dragon(), Knight(), Healer()]
    }

    ///Private method called in the displayTeamComposeGameMenu() to fill the team array of the playing player
    private func composeTeam(countdown: Int) {
        print("Please choose a character from 1 to \(countdown) : ", terminator: "")
        if let choice = readLine() {

            if let choiceNbr = Int(choice), choiceNbr < 4 {
                print("Please name the hero you choose :")
                if let name = readLine(), !name.isEmpty {
                    if isCharacterNameAvailable(input: name) {
                        let removed = characterTypes.remove(at: choiceNbr - 1)
                        removed.name = name
                        players[whoIsPlaying - 1].addTeamHero(hero: removed)
                    } else {
                        print("\nThis name is not available, please choose another one !")
                        composeTeam(countdown: countdown)
                    }
                } else {
                    print("\nWrong input, please retry !")
                    composeTeam(countdown: countdown)
                }
            } else {
                print("\nWrong input, please retry !")
                composeTeam(countdown: countdown)
            }

        } else {
            print("\nWrong input, please retry !")
            composeTeam(countdown: countdown)
        }
    }

    ///Private method that is called right after the user is asked to name his hero
    ///to check that the given name is not already taken
    private func isCharacterNameAvailable(input: String) -> Bool {
        if characterNames.contains(input) {
            return false
        }
        characterNames.append(input)
        return true
    }

    ///Private method that is called in start() to display the composing team menu
    private func displayTeamComposeGameMenu() {
        var i = 0

        print(players[whoIsPlaying - 1].name + "'s turn :")

        while i < 3 {
            print("\nPlease select your character number \(i + 1) among the following list :")
            displayAvailableCharacterTypes(countdown: 3 - i)
            composeTeam(countdown: 3 - i)
            i += 1
        }
    }

    ///Private method called at the end of the game that show all the team infos, the winner and the current turn
    private func displayGameInfos(winner: Player, looser: Player, turn: Int) {
        print("\nWinner's team :")
        winner.displayTeamInfo(team: winner.team)
        print("\nLooser's team :")
        looser.displayTeamInfo(team: looser.team)
        print("\n")
        print("Player " + String(winner.id) + " beats Player " + String(looser.id) + " on turn number " + String(turn) + "\n")
    }


    /// Method that calls player.hasLost() and tells if the game is ended for a given turn.
    private func isGameEnded(turn: Int) -> Bool {

        for player in players {
            if player.hasLost() {
                player.id == 1 ?
                    displayGameInfos(winner: players[1], looser: player, turn: turn) :
                    displayGameInfos(winner: players[0], looser: player, turn: turn)
                return true
            }
        }

        return false
    }
}
