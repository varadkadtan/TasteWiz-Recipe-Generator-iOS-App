import SwiftUI

struct BackgroundView: View {
    var body: some View {
    
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 490, height: 900)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.51, green: 0.73, blue: 0.71), location: 0.40),
                                Gradient.Stop(color: .white.opacity(0.54), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 4)
            }
        }
    }

struct Page1: View {
    var body: some View {
        ZStack {
            BackgroundView()
            VStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 352, height: 306)
                    .background(
                        Image("Image 33")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 352, height: 350)
                            .clipped()
                    )
               
                Text("Scan your Vegetables")
                  .font(
                    Font.custom("AvenirNextCondensed-Bold", size: 32)
                      .weight(.bold)
                  )
                  .kerning(0.64)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                  .frame(width: 336, height: 53, alignment: .top)
                  .offset(y:70)
                
                Text("Instantly add veggies to the recipes \nwith our scan vegetable feature")
                  .font(Font.custom("Roboto", size: 20))
                  .kerning(0.4)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                  .frame(width: 418, height: 84, alignment: .top)
                  .offset(y:80)
            }
        }
    }
}

struct Page2: View {
    var body: some View {
        ZStack {
            BackgroundView()
            VStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 352, height: 306)
                    .background(
                        Image("Image 32")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 352, height: 350)
                            .clipped()
                    )
               
                Text("Decide What to Cook")
                  .font(Font.custom("AvenirNextCondensed-Bold", size: 32)
                      .weight(.bold)
                  )
                  .kerning(0.64)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                  .frame(width: 336, height: 53, alignment: .top)
                  .offset(y:70)
                
                Text("Save time with our meal decision tool \nMaking it easy to choose your meal")
                  .font(Font.custom("Roboto", size: 20))
                  .kerning(0.4)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                  .frame(width: 418, height: 84, alignment: .top)
                  .offset(y:80)
            }
        }
    }
}

import SwiftUI

import SwiftUI

import SwiftUI

struct Page3: View {
    @State private var navigateToPrefPage = false // Add state to control navigation
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 20) { // Add spacing between views
               
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 352, height: 306)
                    .background(
                        Image("Image 31")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 352, height: 350)
                            .clipped()
                    )
                    .offset(y:60)

                Text("Cook your Meal")
                    .font(
                        Font.custom("AvenirNextCondensed-Bold", size: 32)
                            .weight(.bold)
                    )
                    .kerning(0.64)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                    .frame(width: 336, height: 53, alignment: .top)
                    .offset(y:120)
                
                Text("Effortlessly cook your meal with \nour step-by-step instructions")
                    .font(Font.custom("Roboto", size: 20))
                    .kerning(0.4)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                    .frame(width: 418, height: 84, alignment: .top)
                    .offset(y:120)

                Spacer() // Add spacer to push button to the bottom
                ZStack{
                    Button(action: {
                        // Set state to true to trigger navigation
                        navigateToPrefPage = true
                    })
                    {
                        Image(systemName: "chevron.right.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                    }
                }
                .offset(y:60)
            }
            .padding(.vertical, 180) // Adjust vertical padding
        }
        .fullScreenCover(isPresented: $navigateToPrefPage) {
            PrefPage()
        }
        .navigationBarHidden(true) // Hide navigation bar
    }
}





struct StartPage2: View {
    @State private var currentIndex: Int = 0
    
    let slides: [AnyView] = [
        AnyView(Page1()),
        AnyView(Page2()),
        AnyView(Page3())
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<slides.count) { index in
                    self.slides[index]
                        .tag(index)
                        .padding(0) // Set padding to 0
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .gesture(DragGesture()
                .onEnded({ (gesture) in
                    let swipeThreshold: CGFloat = 50
                    if gesture.translation.width > swipeThreshold {
                        withAnimation {
                            currentIndex = (currentIndex > 0) ? currentIndex - 1 : slides.count - 1
                        }
                    } else if gesture.translation.width < -swipeThreshold {
                        withAnimation {
                            currentIndex = (currentIndex < slides.count - 1) ? currentIndex + 1 : 0
                        }
                    }
                })
            )
          //  .padding(-30) // Set padding to 0 for the entire TabView
        }
        .ignoresSafeArea(edges: .top) // Ignore top safe area
        .ignoresSafeArea(edges: .bottom)
    }
}



struct StartPage2_Previews: PreviewProvider {
    static var previews: some View {
        StartPage2()
    }
}
