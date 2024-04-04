import SwiftUI

struct PrefPage: View {
    @StateObject private var selectedPreferences = SelectedPreferences()
    
    @State private var isContinueButtonClicked = false

    var body: some View {
        NavigationView {
            VStack {
              
                    Image("Image 48")
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 312, height: 122)
                      .clipped()
                      .offset(y:10)
                      
                  
                Spacer()
                Spacer()
                Text("Choose your meal type")
                    .font(
                        Font.custom("AvenirNextCondensed-Bold", size: 22)
                            .weight(.bold)
                    )
                    .kerning(0.66)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.28, green: 0.27, blue: 0.3))
                    .offset(y:15)
                
                VStack(spacing: 20) {
                    MealTypeSelection(imageName: "Image 39", mealType: .breakfast)
                    MealTypeSelection(imageName: "Image 40", mealType: .lunch)
                    MealTypeSelection(imageName: "Image 41", mealType: .dinner)
                }
                .padding(.top, 20)
                
                Text("Choose your preferred cuisine")
                    .font(
                        Font.custom("AvenirNextCondensed-Bold", size: 22)
                            .weight(.bold)
                    )
                    .kerning(0.44)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                    .padding(.top, 20)
                    .offset(y:15)
                
                VStack(spacing: 20) {
                    CuisineSelection(imageName: "Image 42", cuisine: .northIndian)
                    HStack(spacing: 10) {
                        CuisineSelection(imageName: "Image 43", cuisine: .chinese)
                        CuisineSelection(imageName: "Image 44", cuisine: .mexican)
                    }
                    HStack(spacing: 10) {
                        CuisineSelection(imageName: "Image 45", cuisine: .southIndian)
                        CuisineSelection(imageName: "Image 46", cuisine: .italian)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Button(action: {
                    // Set state to true to trigger navigation
                    isContinueButtonClicked = true
                }) {
                    Text("Continue")
                        .font(
                            Font.custom("Roboto", size: 20)
                                .weight(.bold)
                        )
                        .kerning(0.4)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 260, height: 66)
                        .background(Color(red: 0.51, green: 0.73, blue: 0.71))
                        .cornerRadius(6)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                }
                .fullScreenCover(isPresented: $isContinueButtonClicked) {
                    ContentView(selectedPreferences: selectedPreferences)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                .padding(.bottom, 20) // Add padding to separate button from bottom
            }
            .navigationBarHidden(true) // Hide navigation bar
            
        }
        .environmentObject(selectedPreferences)
    }
}

struct MealTypeSelection: View {
    @EnvironmentObject var selectedPreferences: SelectedPreferences
    var imageName: String
    var mealType: MealType
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(selectedPreferences.selectedMealType == mealType ? .yellow : .clear)
                .cornerRadius(14)
            
            HStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 50) // Adjust the size as needed
                
                 // Add spacer to push the text to the center
                
                Text(mealType.rawValue)
                    .font(
                        Font.custom("Roboto", size: 20)
                            .weight(.bold)
                    )
                    .kerning(0.4)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                
                Spacer() // Add spacer to push the text to the center
            }
        }
        .frame(width: 196, height: 49)
        .background(Color(red: 0.9, green: 0.92, blue: 0.95))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        .onTapGesture {
            selectedPreferences.selectedMealType = mealType
        }
    }
}


struct CuisineSelection: View {
    @EnvironmentObject var selectedPreferences: SelectedPreferences
    var imageName: String
    var cuisine: Cuisine
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(selectedPreferences.selectedCuisine == cuisine ? .yellow : .clear)
                .cornerRadius(14)
            
            HStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50) // Adjust the size as needed
                
                // Add spacer to push the text to the center
                
                Text(cuisine.rawValue)
                    .font(
                        Font.custom("Roboto", size: 20)
                            .weight(.bold)
                    )
                    .kerning(0.4)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                
                 // Add spacer to push the text to the center
            }
        }
        .frame(width:186, height: 49)
        .background(Color(red: 0.9, green: 0.92, blue: 0.95))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        .onTapGesture {
            selectedPreferences.selectedCuisine = cuisine
        }
    }
}



class SelectedPreferences: ObservableObject {
    @Published var selectedMealType: MealType?
    @Published var selectedCuisine: Cuisine?
}

struct PrefPage_Previews: PreviewProvider {
    static var previews: some View {
        PrefPage()
    }
}
enum Cuisine: String {
    case northIndian = "North Indian"
    case chinese = "Chinese"
    case mexican = "Mexican"
    case southIndian = "South Indian"
    case italian = "Italian"
    // Add more cuisines as needed
}

enum MealType: String {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    // Add more meal types as needed
}
