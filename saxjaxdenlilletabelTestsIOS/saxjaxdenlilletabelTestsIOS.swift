//
//  saxjaxdenlilletabelTestsIOS.swift
//  saxjaxdenlilletabelTestsIOS
//
//  Created by Jakob Skov Søndergård on 01/01/2022.
//

import XCTest
@testable import saxjaxdenlilletabel

class saxjaxdenlilletabelTestsIOS: XCTestCase {
  var sut:GameModel!

    override func setUpWithError() throws {
      sut = GameModel()
      continueAfterFailure = true
    }

    override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()

    }

  func testGet1Point(){
      sut.gamestate=[[1,2,3,4,5,6,7,8,9,10],
                     [2,4,nil,nil,nil,nil,nil,nil,nil,nil],
                     [3,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                     [4,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                     [5,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                     [6,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                     [7,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                     [8,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                     [9,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                     [10,nil,nil,nil,nil,nil,nil,nil,nil,nil]]
      sut.getPoint()
      XCTAssertEqual(sut.points, 1)
  }

  func testGet_1_Point_By_Repeating_Same_Value(){
    sut.gamestate[1][2]=6
    sut.gamestate[1][2]=6
    sut.gamestate[1][2]=6
    sut.gamestate[1][2]=6

    sut.getPoint()
    XCTAssertEqual(sut.points, 1)
  }

  func testGet4Point(){

    sut.gamestate[1][1]=4
    sut.gamestate[2][2]=9
    sut.gamestate[3][3]=16
    sut.gamestate[4][4]=25

    sut.getPoint()
    XCTAssertEqual(sut.points, 4)
  }

  func testGet2PointByUncorrectingAValue(){

    sut.gamestate[1][1]=4
    sut.gamestate[2][2]=9
    sut.gamestate[3][3]=16
    sut.gamestate[3][3]=15

    sut.getPoint()
    XCTAssertEqual(sut.points, 2)
  }

  func testFilleGame_from_0_Points_should_return_0_Points(){

    sut.fillGame()
    sut.getPoint()
    sut.fillGame()
    sut.getPoint()

    XCTAssertEqual(sut.points, 0)
  }

  func testFilleGame_from_23_points_should_return_23_Points(){

    sut.points = 23

    sut.fillGame()
    sut.getPoint()
    sut.fillGame()
    sut.getPoint()

    XCTAssertEqual(sut.points, 23)
  }



//  func testFahrenheitToCelcius() throws {
//
//    let expect1:Double = 0
//          let input1 = 32.0
//
//          let output1 = sut.convertToCelsius(fahrenheit: input1)
//
//    XCTAssertEqual(output1, expect1,"got:\(output1)\nexpected:\(expect1)")
//
//    let expect2:Double = 100
//    let input2 = 212.0
//
//    let output2 = sut.convertToCelsius(fahrenheit: input2)
//
//    XCTAssertEqual(output2, expect2,"got:\(output2)\nexpected:\(expect2)")
//
//  }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
