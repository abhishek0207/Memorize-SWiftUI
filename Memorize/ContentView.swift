//
//  ContentView.swift
//  Memorize
//
//  Created by Ahuja, Abhishek on 5/27/22.
//

import SwiftUI


struct ContentView: View {

    @ObservedObject var viewModel : EmojiMemoryGame
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            Spacer()
            Text("Score : \(viewModel.getScore())")
                .font(.title2)
            Text("Category : \(viewModel.currentTheme().name)")
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) {
                card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
            }
        }
        }
        .padding(.horizontal)
        .foregroundColor(viewModel.currentTheme().fillColor)
            Spacer()
            Button(action: {
                viewModel.restartGame()
            }, label: {
                Text("New Game")
                    .font(.largeTitle)
            })
//            HStack {
//                Button(action: {
//                    selectedIndex = 0
//                }) {
//                    VStack {
//                        Image(systemName: "car.fill")
//                            .font(.largeTitle)
//                        Text("Vehicles")
//                            .font(.subheadline)
//                    }
//                }
//            Spacer()
//                Button(action: {
//                    selectedIndex = 1
//                }) {
//                    VStack {
//                        Image(systemName: "heart.fill")
//                            .font(.largeTitle)
//                        Text("Hearts")
//                            .font(.subheadline)
//                    }
//                }
//            Spacer()
//                Button(action: {
//                    selectedIndex = 2
//                }) {
//                    VStack {
//                        Image(systemName: "flag.fill")
//                            .font(.largeTitle)
//                        Text("Flags")
//                            .font(.subheadline)
//                    }
//                }
//
//            }
//            .padding(.horizontal)
        }
    }
//    var remove : some View {
//             Button(action: {
//                 if cardCount > 1 {
//                cardCount-=1
//            }
//            }){
//                Image(systemName: "minus.circle")
//            }
//    }
//    var add : some View {
//        Button(action: {
//            if cardCount < allEmojis[selectedIndex].count {
//            cardCount+=1
//            }
//        }){
//            Image(systemName: "plus.circle")
//        }
//    }
}

struct CardView: View {
    var card : MemoryGame<String>.Card
    var body: some View {
        GeometryReader {
            geometry in
            ZStack {
                if card.isFaceUp {
                RoundedRectangle(cornerRadius: 20)
                    .fill()
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 20)
                .strokeBorder(lineWidth: 3)
                    Text(card.content)
                        .font(.system(size: geometry.size.width * 0.8))
                } else {
                    RoundedRectangle(cornerRadius: 20)
                    .fill()
                }
            }
        }

    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}

