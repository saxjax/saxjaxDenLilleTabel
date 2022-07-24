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
  @State var showMathPlaceholder = false
  
    var body: some View {


      VStack {
        ZStack {
          VStack {
            HStack {
              Text("Points:\(m.points)").frame(alignment:.topLeading)
              Spacer()
              Text("Spil nr:\(m.gameNr)").frame(alignment:.topTrailing)
            }
          }
        }

//        Text("Til min søde Asta Luna").font(.title)
        Text("Den Lille Tabel").font(.title)
        Text("skriv de manglende tal, feks: 2,4,6,8...")

        VStack {
          ForEach((0...9), id: \.self){row in
            HStack{
              ForEach((0...9), id: \.self){column in
                Field(id: pos(row: row, col: column),
                      fieldValue: $m.gamestate[row][column],
                      facit: m.facit[row][column]!,
                       placeholderIsMath: $showMathPlaceholder)
                  .frame(minWidth: 25, idealWidth: 50, maxWidth: 100, minHeight: 25, idealHeight: 50, maxHeight: 100, alignment: .center).focused($isFocused)
                  .help(Text("\(row+1)x\(column+1)"))
              }
            }
          }
          Spacer()
          Spacer()
          Spacer()
        }
        Toggle("vis regnestykker", isOn: $showMathPlaceholder)
#if os(macOS)
        HStack{
          Button(m.tableFilled ?  "Vend tilbage" :"Fyld Tabel" ) {
            m.fillGame()
            isFocused = false
          }
          Button("Nyt spil") {
            m.resetGameFields()
            isFocused = false
          }
          Button("Saml point:\(m.potentialPoints)") {
            m.getPoint()
            isFocused = false
          }
        }
#endif
      }.scaledToFit().padding()
        .toolbar {

          ToolbarItem(placement: .keyboard) {
            Button("Luk") {
              isFocused = false
            }
          }
          ToolbarItem(placement: .keyboard) {
            Button("nyt spil") {
              m.resetGameFields()
              isFocused = false
            }
          }
          ToolbarItem(placement: .keyboard) {
            Button(m.tableFilled ?  "Vend tilbage" :"Fyld Tabel") {
              m.fillGame()
              isFocused = false
            }
          }
          ToolbarItem(placement: .keyboard) {
              Button("Saml point:\(m.potentialPoints)") {
                m.getPoint()
                isFocused = false
              }
            }
        }

    }


  struct ContentView_Previews_Dark: PreviewProvider {
      static var previews: some View {
        ContentView().preferredColorScheme(.dark)
      }
  }
  struct ContentView_Previews_Light: PreviewProvider {
    static var previews: some View {
      ContentView().preferredColorScheme(.light)    }
  }

  struct Field: View {
    let id:pos
    @Binding var fieldValue: Int?
    let facit: Int
    @Binding var placeholderIsMath: Bool
    var placeholder:String {placeholderIsMath ? "\(id.row+1)x\(id.col+1)" : "X"}

    var body: some View {
      let isCorrect = facit==fieldValue
    #if os(macOS)
      TextField(placeholder, value: $fieldValue ,formatter: NumberFormatter())

        .textFieldStyle(PlainTextFieldStyle())
        .multilineTextAlignment(.center)
        .background(isCorrect ? Color.green : Color.clear)
        .font(isCorrect ? Font.title : Font.footnote)
        .minimumScaleFactor(0.01)



    #else
      TextField(placeholder, value: $fieldValue ,formatter: NumberFormatter())
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .background(isCorrect ? Color.green : Color.clear)
        .font(isCorrect ? Font.title2 : Font.footnote)
        .minimumScaleFactor(0.01)

    #endif
    }
  }
}
