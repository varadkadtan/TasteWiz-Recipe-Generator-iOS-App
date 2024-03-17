import SwiftUI

struct ContentView: View {
    @State private var showProfilePage = false
    @State private var profileRecipe: (String, UIImage?)?
    @State private var savedRecipe: String?
    @State private var savedRecipes: [(String, UIImage)] = []
    @State private var isLoading = false
    @State private var chat = ""
    @State private var generatedRecipe = ""
    @State private var isRecipePopupVisible = false
    @State private var isFetchingRecipe = false
    @State private var isCameraActive = true
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Good Morning Jenny!")
                        .font(Font.custom("Epilogue", size: 27).weight(.bold))
                        .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                        .offset(x: -15)
                    
                    NavigationLink(destination: ProfilePage()) {
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 62, height: 62)
                            .overlay(
                                Image("Image")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 62, height: 62)
                                    .clipShape(Circle())
                                    .offset(x: 10)
                            )
                    }
                    .navigationBarBackButtonHidden(true)
                }
                .offset(y: -55)
                
                Text("Ready for Breakfast?")
                    .font(Font.custom("Inter", size: 14))
                    .foregroundColor(Color(red: 0.56, green: 0.58, blue: 0.63))
                    .offset(x: -110, y: -65)
                
                NavigationLink(destination: SScannerPage()) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 351, height: 165)
                        .background(
                            Image("Image 20")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 371, height: 165)
                                .clipped()
                        )
                        .cornerRadius(45)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        .offset(y: -50)
                }
                
                HStack {
                    Text("Today's Picks")
                        .font(Font.custom("Inter", size: 18))
                        .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                        .offset(x: -120)
//                    Text("See All")
//                        .font(Font.custom("Inter", size: 14))
//                        .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
//                        .offset(x: 100)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<3) { _ in // Change 3 to the number of items you have
                            ZStack {
                                HStack {
                                    VStack {
                                        Text("Bread & Egg\nMorning Casserole")
                                            .font(Font.custom("Inter", size: 16))
                                            .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                                            .offset(x: -20)
                                        
                                        Text("\"Egg, garlic clove, medium.")
                                            .font(Font.custom("Inter", size: 14))
                                            .foregroundColor(Color(red: 0.74, green: 0.76, blue: 0.79))
                                            .offset(y: 10)
                                    }
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 102, height: 104)
                                        .background(
                                            Image("Image 1")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 102, height: 104)
                                                .clipped()
                                        )
                                        .cornerRadius(4)
                                }
                                .padding(.vertical, 20)
                            }
                            .frame(width: 321, height: 128)
                            .background(Color(red: 1, green: 1, blue: 1))
                            .cornerRadius(22.62477)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                            .offset(y: -35)
                            .onTapGesture {
                                generateRRecipe(for: "Bread and egg morning casserole")
                            }
                        }
                    }
                    .padding(.top, 30)
                }
                
                ZStack {
                    VStack {
                        HStack {
                            Text("Quick Search")
                                .font(Font.custom("Inter", size: 14))
                                .foregroundColor(.black)
                                .offset(x: -130)
                            
//                            Text("Refresh")
//                                .font(Font.custom("Inter", size: 14))
//                                .foregroundColor(Color(red: 0.05, green: 0.05, blue: 0.05))
//                                .offset(x: 80)
//
//                            Image("Image 2")
//                                .frame(width: 16, height: 16)
//                                .offset(x: 80)
                        }
                        .offset(y: -45)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: -30) { // Use positive spacing
                                ForEach(0..<3) { _ in
                                    VStack(alignment: .leading, spacing: 4.66913) { // Bread Based Recipes
                                        Text("Bread Based Recipes")
                                            .font(Font.custom("Inter", size: 16))
                                            .foregroundColor(Color(red: 0.15, green: 0.16, blue: 0.19))
                                        
                                        Text("Bread, garlic clove, medium\nonion, lemon juice")
                                            .font(Font.custom("Inter", size: 16))
                                            .foregroundColor(Color(red: 0.56, green: 0.58, blue: 0.63))
                                            .frame(width: 205, alignment: .topLeading)
                                    }
                                    .padding(.leading, 19)
                                    .padding(.trailing, 30)
                                    .padding(.top, 19.31608)
                                    .padding(.bottom, 10.01479)
                                    .background(Color(red: 1, green: 0.98, blue: 0.98))
                                    .cornerRadius(25)
                                    .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.07), radius: 0.5, x: 0, y: 0)
                                    .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)
                                    .onTapGesture {
                                        generateRRecipe(for: "Bread Based Recipe")
                                    }
                                    //.shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                }
                                .padding(.horizontal, 20) // Add padding to the HStack if needed
                            }
                        }

                        .offset(y: -30) //white box finsih
                        
                        HStack {
                            TextField("How to make egg curry?", text: $chat)
                                .font(Font.custom("Inter", size: 18))
                                .foregroundColor(Color(red: 0.22, green: 0.22, blue: 0.22))
                                .offset(x: 10)
                            
                            Button(action: {
                                generateRecipe()
                            }) {
                                Image("Image 3")
                                    .frame(width: 24, height: 24)
                                    .offset(x: -10)
                            }
                            .sheet(isPresented: $isRecipePopupVisible) {
                                RecipeDisplayPage(generatedRecipe: generatedRecipe)
                            }
                        }
                        .modifier(KeyboardAwareModifier())
                        .padding(.leading, 20)
                        .padding(.trailing, 19)
                        .padding(.top, 12)
                        .padding(.bottom, 11)
                        .background(.black.opacity(0))
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: -0.5)
                                .size(width: 374, height: 50)
                                .stroke(.black, lineWidth: 1)
                                .offset(x: 20)
                        )
                    }
                    //.offset(y:2)
                }
                .frame(width: 415, height: 354)
                .background(Color(red: 0.99, green: 0.71, blue: 0))
                .cornerRadius(58) //yellow box finish
                .padding(-10)
            }
            .offset(y: 54)
        }
        .navigationBarBackButtonHidden(true)
        .overlay(
            // Loading indicator
            Group {
                if isFetchingRecipe {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.green)
                        .padding(.bottom, 20)
                }
            }
            
        )
        .sheet(isPresented: $isRecipePopupVisible) {
            if isFetchingRecipe {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.green)
            } else {
                RecipeDisplayPage(generatedRecipe: generatedRecipe)
            }
        }
    }
    
    private func generateRRecipe(for category: String) {
        let prompt = "\(category)\nStep-by-Step Recipe and also mention ingredients to use, be friendly and also consider user is a bachelor so he/she has minimum idea of cooking."
        sendPromptToChatGPT(prompt: prompt)
    }

    
    private func generateRecipe() {
        isLoading = true
        let prompt = "\(chat)\nStep-by-Step Recipe and also mention ingredients to use, be friendly and also consider user is a bachelor so he/she has minimum idea of cooking."
        sendPromptToChatGPT(prompt: prompt)
    }
    
    private func sendPromptToChatGPT(prompt: String) {
        isLoading = false
        isRecipePopupVisible = true
        guard let url = URL(string: "") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "model": "",
            "messages": [[: prompt]]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ChatGPTResponse.self, from: data)
                
                if !decodedResponse.choices.isEmpty {
                    let generatedRecipe = decodedResponse.choices[0].message.content
                    DispatchQueue.main.async {
                        self.generatedRecipe = generatedRecipe
                        self.isRecipePopupVisible = true
                    }
                } else {
                    print("Empty response choices")
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
}
struct RecipeDisplayPage: View {
    var generatedRecipe: String

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Step-by-Step Recipe")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                ForEach(generatedRecipe.components(separatedBy: "\n"), id: \.self) { step in
                    if !step.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        RecipeStepView(step: step)
                            .padding(.horizontal)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("Generated Recipe", displayMode: .inline)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
