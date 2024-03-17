//
//  RecipeGeneratedPage.swift
//  TasteWiz
//
//  Created by user46a on 30/12/23.
//

import SwiftUI

struct RecipeGeneratedPage: View {
    var body: some View {
        NavigationView{
            
            
            //     VStack{
            
            
            ZStack {
                
                VStack{
                    Text("8 Recipes are Generated")
                        .font(
                            Font.custom("Epilogue", size: 20)
                                .weight(.bold)
                        )
                        .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                        .offset(x:-58,y:-40)
                    
                    Text("Egg, leek, tomato, mushroom, green chili")
                        .font(Font.custom("Inter", size: 14))
                        .foregroundColor(Color(red: 0.56, green: 0.58, blue: 0.63))
                        .offset(x:-40,y:-30)
                    VStack{
                        ZStack {
                            
                            HStack{
                                
                                
                                VStack{
                                    Text("Bread & Egg Morning\nCasserole")
                                        .font(Font.custom("Inter", size: 14))
                                        .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                                        .offset(x:-15)
                                    Text("Egg garlic clove, medium\nonion, lemon juice, tomato, m..")
                                        .font(Font.custom("Inter", size: 12))
                                        .foregroundColor(Color(red: 0.56, green: 0.58, blue: 0.63))
                                    
                                }//Vstack
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 134, height: 135)
                                    .background(
                                        Image("Image 15")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 134, height: 135)
                                            .clipped()
                                    )
                                    .cornerRadius(14)
                                    .offset(x:18)
                            }//hstack
                            
                        }//zstack
                        .frame(width: 339, height: 135)
                        .background(Color(red: 1, green: 1, blue: 1))
                        .cornerRadius(23.15625)
                        .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 2, x: 0, y: 4)
                        
                        ZStack {
                            HStack{
                                
                                
                                VStack{
                                    Text("Thailand Chicken and\nOmellete")
                                        .font(Font.custom("Inter", size: 14))
                                        .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                                        .offset(x:-15)
                                    Text("Egg, tomato,medium onion\nlemon juice, green chilli papri..")
                                        .font(Font.custom("Inter", size: 12))
                                        .foregroundColor(Color(red: 0.56, green: 0.58, blue: 0.63))
                                    
                                }//Vstack
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 134, height: 135)
                                    .background(
                                        Image("Image 16")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 134, height: 135)
                                            .clipped()
                                    )
                                    .cornerRadius(14)
                                    .offset(x:18)
                            }//hstack
                        }//zstack
                        .frame(width: 339, height: 135)
                        .background(Color(red: 1, green: 1, blue: 1))
                        .cornerRadius(23.15625)
                        .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 2, x: 0, y: 4)
                        
                        NavigationLink(destination: RecipePage()) {
                            ZStack {
                                HStack{
                                    
                                    
                                    VStack{
                                        Text("Green Chili Fried Rice\nwith Egg &Cucumber")
                                            .font(Font.custom("Inter", size: 14))
                                            .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                                            .offset(x:-15)
                                        Text("Egg, rice, cucumber, lemon an\njuice, tomato, red chill, leek, c.")
                                            .font(Font.custom("Inter", size: 12))
                                            .foregroundColor(Color(red: 0.56, green: 0.58, blue: 0.63))
                                        
                                    }//Vstack
                                    
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 134, height: 135)
                                    //                                                .offset(x:1)
                                        .background(
                                            Image("Image 17")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 134, height: 135)
                                                .clipped()
                                            
                                        )
                                        .cornerRadius(14)
                                        .offset(x:18)
                                }//hstack
                            }//zstack
                        }
                        .frame(width: 339, height: 135)
                        .background(Color(red: 1, green: 1, blue: 1))
                        .cornerRadius(23.15625)
                        .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 2, x: 0, y: 4)
                        
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 340, height: 135)
                        
                            .background(
                                Image("Image 19")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 340, height: 135)
                                    .clipped()
                                    .overlay(
                                        Image("Image 21")
                                            .frame(width: 57, height: 57)
                                            .background(.black.opacity(0))
                                        //                                        .background(.white)
                                    )
                            )
                            .cornerRadius(23.16)
                        
                        
                    }//vstack
                    .offset(y:0)
                }//zstack
                .frame(width: 398, height: 747)
                .background(Color.white)
                .cornerRadius(10)
                .offset(y:50)
                
            }
            
        }
        //                    .offset(y:50)
        
        //                .offset(y:100)
        
        // .cornerRadius(68)
    }
    
}

struct RecipeGeneratedPage_Previews: PreviewProvider {
    static var previews: some View {
        RecipeGeneratedPage()
    }
}
