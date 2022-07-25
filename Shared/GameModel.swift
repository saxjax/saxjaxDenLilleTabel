//
//  GameModel.swift
//  denlilletabel
//
//  Created by Jakob Skov Søndergård on 27/12/221.
//

import Foundation
import Accessibility
import SwiftUI
class GameModel:ObservableObject {

  init() {
    pointStatus = initialpointStatus
    gamestate = initialState
    reachedState = gamestate
    potentialPoints = 0
    tableFilled = false
  }

  //  GameStates
  //  TODO:Implement that points change when a field is updated.
  typealias FieldTuple = (row: Int, col: Int,val: Int?)
  @Published var ActiveValue:FieldTuple = (row: 0, col: 0,val: 0)  {
    willSet{changedGameState(row: newValue.row, col: newValue.col, value: newValue.val!)}
  }

  @Published var gamestate:[[Int?]] = [[1,2,3,4,5,6,7,8,9,10],
                                       [2,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [3,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [4,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [5,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [6,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [7,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [8,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [9,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [10,nil,nil,nil,nil,nil,nil,nil,nil,nil]
  ]{ didSet{potentialPoints += GetpotentialPoints}}
  
  private var reachedState:[[Int?]] = [[nil]]

  private var pointStatus:[[Bool?]] = [[nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                               [nil,false,false,false,false,false,false,false,false,false],
                               [nil,false,false,false,false,false,false,false,false,false],
                               [nil,false,false,false,false,false,false,false,false,false],
                               [nil,false,false,false,false,false,false,false,false,false],
                               [nil,false,false,false,false,false,false,false,false,false],
                               [nil,false,false,false,false,false,false,false,false,false],
                               [nil,false,false,false,false,false,false,false,false,false],
                               [nil,false,false,false,false,false,false,false,false,false],
                               [nil,false,false,false,false,false,false,false,false,false]
  ]

   let facit:[[Int?]] = [[1,2,3,4,5,6,7,8,9,10],
                        [2,4,6,8,10,12,14,16,18,20],
                        [3,6,9,12,15,18,21,24,27,30],
                        [4,8,12,16,20,24,28,32,36,40],
                        [5,10,15,20,25,30,35,40,45,50],
                        [6,12,18,24,30,36,42,48,54,60],
                        [7,14,21,28,35,42,49,56,63,70],
                        [8,16,24,32,40,48,56,64,72,80],
                        [9,18,27,36,45,54,63,72,81,90],
                        [10,20,30,40,50,60,70,80,90,100]
  ]

  private let initialState:[[Int?]] = [[1,2,3,4,5,6,7,8,9,10],
                                       [2,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [3,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [4,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [5,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [6,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [7,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [8,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [9,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [10,nil,nil,nil,nil,nil,nil,nil,nil,nil]]

  private var initialpointStatus:[[Bool?]] = [[nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                       [nil,false,false,false,false,false,false,false,false,false],
                                       [nil,false,false,false,false,false,false,false,false,false],
                                       [nil,false,false,false,false,false,false,false,false,false],
                                       [nil,false,false,false,false,false,false,false,false,false],
                                       [nil,false,false,false,false,false,false,false,false,false],
                                       [nil,false,false,false,false,false,false,false,false,false],
                                       [nil,false,false,false,false,false,false,false,false,false],
                                       [nil,false,false,false,false,false,false,false,false,false],
                                              [nil,false,false,false,false,false,false,false,false,false]]

  @Published var gameNr:Int = 1
  @Published var points:Int = 0
  @Published var potentialPoints:Int = 0
  @Published var tableFilled = false

  private var GetpotentialPoints: Int {
    var result:[Int?] = [Int?]()
    if (tableFilled==false){
      for row in 0...9 {
        for col in 0...9{
        if(pointStatus[row][col]==false){
          if (gamestate[row][col] == facit[row][col]) {
            result.append( gamestate[row][col])
            pointStatus[row][col] = true
            reachedState=gamestate
          }
        }
          else {
//            pointStatus[row][col] = false
          }
        }
      }

      return result.count
    }
    return 0
  }


  //  Points
//  let fillCost = 100
  let fieldPoint = 1
  let fullTablePoint = 100


  func changedGameState(row:Int,col:Int,value: Int){
    if (fieldIsCorrect(row: row, col: col) == true && pointStatus[row][col] != nil && pointStatus[row][col]==false){
      gamestate[row][col]=value
      pointStatus[row][col] = true
      points += 1
    }
    else if (fieldIsCorrect(row: row, col: col) == false && pointStatus[row][col] != nil && pointStatus[row][col]==true){
      gamestate[row][col]=value
      pointStatus[row][col] = false
      points -= 1
    }
    else {
      gamestate[row][col]=value
    }

  }


  func fieldIsCorrect(row:Int,col:Int)->Bool{
    return gamestate[row][col] == facit[row][col]
  }

  func getPoint(){
    if(tableFilled == false){
//      if(gamestate==facit){
//        points += potentialPoints
//        potentialPoints = 0
//        gamestate=initialState
////      }
      if (potentialPoints > 0){
        points +=  potentialPoints
        potentialPoints = 0
        gamestate=initialState
      }
    }
  }

  func fillGame(){
    tableFilled = !tableFilled

    if(tableFilled==true){
      if(gamestate != facit){
        gamestate=facit
      }
    }
    else if (tableFilled==false) {
      gamestate=reachedState
    }
  }

  func clearField(row:Int,col:Int){
    gamestate[row][col]=nil
  }

  func resetGameFields(){
    pointStatus = initialpointStatus
    gamestate = initialState
    reachedState = gamestate
    potentialPoints = 0
    tableFilled = false
    gameNr += 1
  }
  

}
