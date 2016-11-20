//
//  BattleshipModel.swift
//  BattleShips2
//
//  Created by Wilson Ng on 11/19/16.
//  Copyright © 2016 Wilson Ng. All rights reserved.
//

import Foundation

class BattleshipModel {
    
    // 0 is empty
    // 1 is ship
    // 2 is hit
    // 3 is missed
    // 4 is sunked
    //: 2d array that represents the grid
    var grid : [[Int]] = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    var point : Int = 0
    var ship1 = Ship(newLength: 2)
    var ship2 = Ship(newLength: 3)
    var ship3 = Ship(newLength: 3)
    var ship4 = Ship(newLength: 4)
    var ship5 = Ship(newLength: 5)
    
    //Constructor that gets called when a BattleshipModel is created. It adds all 5 ships into the grid
    init(){
        addShip(ship: ship1)
        addShip(ship: ship2)
        addShip(ship: ship3)
        addShip(ship: ship4)
        addShip(ship: ship5)
    }
    
    //Adds a ship into the grid, where the ship is a given argument
    func addShip(ship:Ship)
    {
        var random = createRandom(length: ship.length) // Creates a random location for the ship in the grid
        //Checks if the location created has conflicts with other boats, if so it creates another random location until there is no conflict
        if checkRandom(length: ship.length, rand: random.rand, x: random.x, y: random.y) == false {
            while checkRandom(length: ship.length, rand: random.rand, x: random.x, y: random.y) == false{
                random = createRandom(length: ship.length)
            }
        }
        //Checks for the alignment. 0 for vertical, 1 for horizontal
        ship.alignment = random.rand
        if random.rand == 0{
            ship.x.insert(random.x, at: 0)
            for i in 0...ship.length-1 {
                grid[random.x][random.y+i] = 1
                ship.y.insert(random.y+i, at: 0)
            }
        }
        else{
            ship.y.insert(random.y, at: 0)
            for i in 0...ship.length-1 {
                grid[random.x+i][random.y] = 1
                ship.x.insert(random.x+i, at: 0)
            }
        }
        
    }
    
    func createRandom(length:Int) -> (rand: Int, x:Int, y:Int){
        let rand = Int(arc4random_uniform(2))
        let range = UInt32(10 - length)
        let x = Int(arc4random_uniform(range))
        let y = Int(arc4random_uniform(range))
        return(rand, x, y)
    }
    
    func checkRandom(length: Int, rand: Int, x: Int, y: Int) -> Bool {
        if rand == 0{
            for i in 0...length-1 {
                if grid[x][y+i] == 1{
                    return false
                }
            }
        }
        else{
            for i in 0...length-1 {
                if grid[x+i][y] == 1{
                    return false
                }
            }
        }
        return true
    }
    
    func launchMissile (x: Int, y: Int) -> String {
        if grid[x][y] == 0{
            grid[x][y] = 3
            return "missed"
        }
        else if grid[x][y] == 1 {
            grid[x][y] = 2
            if checkHitShip(ship: ship1, x: x, y: y){
                changeToSunked(ship: ship1)
                return "sunked"
            }
            if checkHitShip(ship: ship2, x: x, y: y){
                changeToSunked(ship: ship2)
                return "sunked"
            }
            if checkHitShip(ship: ship3, x: x, y: y){
                changeToSunked(ship: ship3)
                return "sunked"
            }
            if checkHitShip(ship: ship4, x: x, y: y){
                changeToSunked(ship: ship4)
                return "sunked"
            }
            if checkHitShip(ship: ship5, x: x, y: y){
                changeToSunked(ship: ship5)
                return "sunked"
            }
            return "hit"
        }
        return "error"
    }
    
    func checkHitShip(ship: Ship, x: Int, y: Int) -> Bool{
        if ship.x.contains(x) && ship.y.contains(y){
            if ship.alignment == 0 {
                ship.hit.insert(y, at: 0)
                if ship.isSunked(){
                    return true
                }
            }
            else {
                ship.hit.insert(x, at: 0)
                if ship.isSunked(){
                    return true
                }
            }
        }
        return false
    }
    
    func checkIfSunked(ship: Ship) -> Bool {
        if ship.isSunked(){
            return true
        }
        return false
    }
    
    func changeToSunked(ship: Ship){
        if ship.alignment == 0{
            for i in ship.y{
                grid[ship.x[0]][i] = 4
            }
        }
        else {
            for i in ship.x{
                grid[i][ship.y[0]] = 4
            }
        }
    }
    
    func checkIfWin() -> Bool {
        if ship1.isSunked(){
            if ship2.isSunked(){
                if ship3.isSunked(){
                    if ship4.isSunked(){
                        if ship5.isSunked(){
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
}

class Ship {
    var x: [Int] = []
    var y: [Int] = []
    var hit: [Int] = []
    var length : Int = 0
    var alignment: Int = 0
    var sunked: Bool = false
    
    init(newLength : Int){
        length = newLength
    }
    
    func isSunked() -> Bool{
        if hit.count == length{
            return true
        }
        return false
    }
}
