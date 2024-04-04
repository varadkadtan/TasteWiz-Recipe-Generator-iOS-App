//
//  StartPage.swift
//  TasteWiz
//
//  Created by user46a on 30/12/23.
//

import SwiftUI

struct StartPage: View {
    var body: some View {
        
        VStack(alignment: .center, spacing: 32) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 508, height: 302)
              .background(
                Image("Image 30")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 308, height: 282)
                  .clipped()
              )
            
          /*  Text("TasteWiz")
              .font(Font.custom("La Belle Aurore", size: 72))
              .foregroundColor(Color(red: 0.25, green: 0.53, blue: 0.51))
              .frame(width: 259, height: 130, alignment: .topLeading)*/
            
                Image("Image 47")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 285, height: 97)
                  .clipped()
              
        }
        .padding(.horizontal, 41)
        .padding(.top, 174)
        .padding(.bottom, 226)
        .frame(width: 490, alignment: .top)
        .background(Color(red: 0.51, green: 0.73, blue: 0.71))
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}
