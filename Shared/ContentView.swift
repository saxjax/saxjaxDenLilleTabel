//
//  ContentView.swift
//  Shared
//
//  Created by Jakob Skov Søndergård on 27/12/2021.
//

import SwiftUI

//struct Field {
//  let id:pos
//  let value:Int
//}
struct pos:Hashable{
  let row:Int
  let col:Int
}

struct ContentView: View {
  @StateObject var m = GameModel()
  @FocusState private var isFocused: Bool
  
    var body: some View {


      VStack {
        ZStack {
          VStack {
            HStack {
              Text("Points:\(m.points)").frame(alignment:.topLeading)
              Spacer()
            }
          }
        }
        Text("Til min søde Asta Luna").font(.title)
        Text("Den Lille Tabel").font(.title)
        Text("skriv de manglende tal, feks: 2,4,6,8...")

        VStack {
          ForEach((0...9), id: \.self){row in
            HStack{
              ForEach((0...9), id: \.self){column in
                Field(id: pos(row: row, col: column),
                      facit:m.facit[row][column],
                      fieldValue: $m.gamestate[row][column])
                  .frame(minWidth: 25, idealWidth: 50, maxWidth: 100, minHeight: 25, idealHeight: 50, maxHeight: 100, alignment: .center).focused($isFocused)
              }
            }
          }
          Spacer()
          Spacer()
          Spacer()
        }

      }.scaledToFit().padding()
        .toolbar {
          ToolbarItem(placement: .keyboard) {
            Button("Færdig") {
              isFocused = false
            }
          }
          ToolbarItem(placement: .keyboard) {
            Button("Udfyld tabel:\(m.fillCost)") {
              m.fillGame()

            }
          }
          ToolbarItem(placement: .keyboard) {
              Button("Saml point:\(m.points)") {
                m.getPoint()
                isFocused = false
              }
            }



        }

    }


  struct ContentView_Previews: PreviewProvider {
      static var previews: some View {
        ContentView()
      }
  }

  struct Field: View {
    let id:pos
    let facit: Int
    @Binding var fieldValue: Int?

    var body: some View {
      let isCorrect = facit==fieldValue
    #if os(macOS)
      TextField("x", value: $fieldValue ,formatter: NumberFormatter())
        .multilineTextAlignment(.center)
        .background(isCorrect ? Color.green : Color.clear)
    #else
      TextField("x", value: $fieldValue ,formatter: NumberFormatter())
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .background(isCorrect ? Color.green : Color.clear)
    #endif
    }
  }
}
