//
//  RecipePage3.swift
//  TasteWiz
//
//  Created by user46a on 03/01/24.
//

import SwiftUI

struct RecipePage3: View {
    var body: some View {
        VStack{
            Text("Egg Fried Rice")
              .font(
                Font.custom("Epilogue", size: 36)
                  .weight(.bold)
              )
              .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
              .offset(y:-15)
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 352, height: 306)
              .background(
                Image("Image 22")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 352, height: 306)
                  .clipped()
              )
              .cornerRadius(29)
              .offset(y:-15)
            
            Text("3. Scramble Eggs:")
              .font(
                Font.custom("Epilogue", size: 20)
                  .weight(.bold)
              )
              .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
              .offset(x:-90,y:10)
            
            Text("\n• Pour the beaten eggs into the hot wok. Allow them to set briefly and then scramble them until they are fully cooked.\n\n• Remove the scrambled eggs from the wok and set them aside.")
              .font(Font.custom("Inter", size: 20))
              .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
              .frame(width: 345, height: 256, alignment: .topLeading).offset(y:12)
            
            NavigationLink(destination: RecipePage4()) {
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

#Preview {
    RecipePage3()
}
