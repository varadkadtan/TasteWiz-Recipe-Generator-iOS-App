import SwiftUI
import Foundation

struct ContentView: View {
    
    @State private var showProfilePage = false
    
    @StateObject var selectedPreferences = SelectedPreferences()

    @State private var profileRecipe: (String, UIImage?)?
    @State private var savedRecipe: String?
    @State private var savedRecipes: [(String, UIImage)] = []
    @State private var isLoading = false
    @State private var chat = ""
   
    @State private var generatedRecipe = ""
    @State private var isRecipePopupVisible = false
    @State private var isFetchingRecipe = false
    @State private var isCameraActive = true
    @State private var currentIndex: Int = 0
    @State private var timer: Timer?
    
       let images = ["Image 36", "Image 37", "Image 38"] // Names of your images
    
    let apiKey = "YOUR_API_KEY"
    
    var body: some View {
        
        NavigationView {
            GeometryReader { _ in
            
            ZStack{
                
                Rectangle()
                
                    .foregroundColor(.clear)
                    .frame(width:429, height:899)
                
                //(red: 0.51, green: 0.73, blue: 0.71)
            //    (red: 1, green: 0.89, blue: 0.57)
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
                VStack{
                    
                    HStack{
                        VStack{
                            Text("Hello Chef !")
                                .font(
                                    Font.custom("AvenirNextCondensed-Bold", size: 46)
                                        .weight(.heavy)
                                )
                                
                                .kerning(0.72)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                                .frame(width: 259, height: 41, alignment: .top)
                                .offset(x:8,y:-10)
                            
                            Text("Ready to Cook?")
                                .font(
                                    Font.custom("AvenirNextCondensed-Bold", size: 20)
                                        .weight(.medium)
                                )
                                .kerning(0.4)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                                .frame(width: 155, height: 32, alignment: .top)
                                .offset(x:-50)
                            
                        }
                        .offset(x:-30,y:-30)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 78, height: 69)
                            .background(
                                Image("Image 30")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 78, height: 69)
                                    .clipped()
                            )
                            .offset(x:2,y:-40)
                    }
                    .offset(y:60)
                    ZStack {
                        
                        
                        HStack {
                            TextField("How to make egg curry?", text: $chat)
                                .font(Font.custom("Inter", size: 20))
                                .foregroundColor(Color(red: 0.22, green: 0.22, blue: 0.22))
                                .padding(.leading, 23)
                                .padding(.trailing, 0)
                            // Adjust as needed
                            
                            Button(action: {
                                generateRecipe()
                            }) {
                                Image("Image 26")
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.trailing, 32)
                        }
                    }
                    .frame(width: 370, height: 70.50849)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .offset(y: 45)
                    .sheet(isPresented: $isRecipePopupVisible) {
                        RecipeDisplayPage(generatedRecipe: generatedRecipe)
                    }
                    
                    
                    
                    VStack{
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 355, height: 181)
                                .background(.white)
                                .cornerRadius(17)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                            
                            Text("Turn your vegetables Into\nMagic !")
                                
                                .font(
                                    Font.custom("AvenirNextCondensed-Bold", size: 24)
                                        .weight(.bold)
                                )
                                .kerning(0.44)
                                .foregroundColor(Color(red: 0.51, green: 0.73, blue: 0.71))
                                .frame(width: 306, height: 67, alignment: .topLeading)
                                .offset(y:-40)
                            
                            ZStack{
                                NavigationLink(destination: SScannerPage().environmentObject(selectedPreferences)) {
                                    // Your button content
                                    
                                    
                                    ZStack{
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 178, height: 52)
                                            .background(Color(red: 1, green: 0.89, blue: 0.57))
                                            .cornerRadius(17)
                                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                        
                                        HStack{
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: 40, height: 40)
                                                .background(
                                                    Image("Image 34")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 40, height: 40)
                                                        .clipped()
                                                )
                                            
                                            Text("SCAN NOW")
                                                .font(
                                                    Font.custom("Roboto", size: 18)
                                                        .weight(.bold)
                                                )
                                                .kerning(0.36)
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .offset(x:-65,y:40)
                                }
                                
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 201, height: 375)
                                    .background(
                                        Image("Image 35")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    )
                                    .shadow(color: .black.opacity(0.25), radius:2, x: 0, y: 4)
                                    .offset(x:100,y:80)
                            }
                            
                        }
                        .offset(y:-20)
                    }
                    
                    Text("Popular Recipes")
                        .font(
                            Font.custom("AvenirNextCondensed-Bold", size: 30)
                                .weight(.bold)
                        )
                        .kerning(0.48)
                        .foregroundColor(Color(red: 0.42, green: 0.41, blue: 0.5))
                        .frame(width: 249, height: 0, alignment: .topLeading)
                        .offset(x:-50,y:-70)
                    
                    ZStack {
                        TabView(selection: $currentIndex) {
                            ForEach(0..<images.count) { index in
                                Image(images[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 370, height: 500)
                                    .tag(index)
                                    .padding(.top, 80)
                                    .padding(.bottom, 50)
                                    .gesture(
                                        TapGesture()
                                            .onEnded { _ in
                                                // Handle tap gesture
                                                handleImageTap(index)
                                            }
                                    )
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                       // .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)
                           // )
                        
                        
                        .onAppear {
                            // Start timer for auto-swipe
                            startTimer()
                        }
                        .onDisappear {
                            // Stop timer when view disappears
                            stopTimer()
                        }
                        .offset(x:-1,y: -80)
                    }
                    
                    
                    
                    
                    
                }
                .padding(.trailing, 10)
                .environmentObject(selectedPreferences)
                .navigationBarBackButtonHidden(true)
                
                .sheet(isPresented: $isRecipePopupVisible) {
                    if isFetchingRecipe {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.green)
                    } else {
                        RecipeDisplayPage(generatedRecipe: generatedRecipe)
                    }
                }
                //.offset(y:-100)
                
                //                ZStack {
                //                    VStack {
                //                        HStack {
                //                            TextField("How to make egg curry?", text: $chat)
                //                                .font(Font.custom("Inter", size: 18))
                //                                .foregroundColor(Color(red: 0.22, green: 0.22, blue: 0.22))
                //                                .offset(x: 10)
                //
                //                            Button(action: {
                //                                generateRecipe()
                //                            }) {
                //                                Image("Image 3")
                //                                    .frame(width: 24, height: 24)
                //                                    .offset(x: -10)
                //                            }
                //                            .sheet(isPresented: $isRecipePopupVisible) {
                //                                RecipeDisplayPage(generatedRecipe: generatedRecipe)
                //                            }
                //                        }
                //                        .modifier(KeyboardAwareModifier())
                //                        .padding(.leading, 20)
                //                        .padding(.trailing, 19)
                //                        .padding(.top, 12)
                //                        .padding(.bottom, 11)
                //                        .background(.black.opacity(0))
                //                        .cornerRadius(4)
                //                        .overlay(
                //                            RoundedRectangle(cornerRadius: 4)
                //                                .inset(by: -0.5)
                //                                .size(width: 374, height: 50)
                //                                .stroke(.black, lineWidth: 1)
                //                                .offset(x: 20)
                //                        )
                //                    }
                //                    //.offset(y:2)
                //                }
                
                
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            
                    
            
            
            
            
            }
        
        
                .frame(width: 420, height: 874)
                .offset(x:3)
                
                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
          // .offset(y: 85)
           .ignoresSafeArea(edges: .top)
            .ignoresSafeArea(edges: .bottom)
            
        }
    func handleImageTap(_ index: Int) {
        // Handle tap gesture on image
        switch index {
        case 0:
            chat = "Wasabi Potato Mash"
        case 1:
            chat = "Sushi Rolls"
        case 2:
            chat = "Paneer Stir Fry"
        default:
            break
        }
        generateRecipe()
    }
       
        
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            withAnimation {
                currentIndex = (currentIndex + 1) % images.count
            }
        }
    }
    
    private func stopTimer() {
        // Invalidate timer to stop it
        // This will ensure that the timer is stopped when the view disappears
        // and doesn't continue running unnecessarily
        timer?.invalidate()
    }
    


    
    private func generateRRecipe(for category: String) {
        let prompt = "\(category)\nStep-by-Step Recipe and also mention ingredients to use, be friendly and also consider user is a bachelor so he/she has minimum idea of cooking."
        sendPromptToChatGPT(prompt: prompt)
    }

    
    private func generateRecipe() {
        isFetchingRecipe = true
        
        isLoading = true
        let prompt = "\(chat)\nStep-by-Step Recipe and also mention ingredients to use, be friendly and also consider user is a bachelor so he/she has minimum idea of cooking."
        sendPromptToChatGPT(prompt: prompt)
    }
    
    private func sendPromptToChatGPT(prompt: String) {
        isLoading = false
        isRecipePopupVisible = true
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [["role": "user", "content": prompt]]
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
                    .foregroundColor(Color(red: 0.51, green: 0.73, blue: 0.71))
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
