//
//  RecipePage2.swift
//  TasteWiz
//
//  Created by user46a on 28/12/23.
//

import SwiftUI

struct RecipePage2: View {
    var body: some View {
        VStack{
            
            HStack{
                
                Text("Egg Fried Rice")
                  .font(
                    Font.custom("Epilogue", size: 32)
                      .weight(.bold)
                  )
                  .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                  .offset(y:-20)
            }
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 352, height: 306)
              .background(
                Image("Image 8")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 352, height: 306)
                  .clipped()
              )
              .cornerRadius(29)
              .offset(y:-15)
            
            
            Text("2. Preheat the pan")
              .font(
                Font.custom("Epilogue", size: 20)
                  .weight(.bold)
              )
              .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
              .offset(x:-90,y:10)
            
            Text("\n• Heat a large wok or a deep skillet over medium-high heat.\n\n• Add a tablespoon of cooking oil.")
              .font(Font.custom("Inter", size: 20))
              .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
              .frame(width: 345, height: 256, alignment: .topLeading)
              .offset(y:20)
            
            NavigationLink(destination: RecipePage3()) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 57, height: 61)
                .background(
                    Image("Image 6")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 57, height: 61)
                        .clipped()
                )
                .rotationEffect(Angle(degrees: 180))
                .offset(y:20)
        }
        }
    }
}

struct RecipePage2_Previews: PreviewProvider {
    static var previews: some View {
        RecipePage2()
    }
}
