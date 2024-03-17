//
//  StartPage.swift
//  TasteWiz
//
//  Created by user46a on 30/12/23.
//

import SwiftUI

struct StartPage: View {
    var body: some View {
        
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 402, height: 900)
          .background(
            Image("Image 9")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 402, height: 900)
              .clipped()
          )
          .cornerRadius(38)
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}
