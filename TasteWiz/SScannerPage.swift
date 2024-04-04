import SwiftUI

import AVFoundation

import CoreML

import AVKit



struct SScannerPage: View {
    
    
    @EnvironmentObject var selectedPreferences: SelectedPreferences
    @State private var isRecipeGeneratedPagePresented = false

    @State private var isRecipePopupVisible = false

        @State private var detectedVegetables: [String] = []

        @State private var selectedVegetables: [String] = []

        @State private var generatedRecipe: String = ""

        @State private var isCameraActive = true

        @State private var isFetchingRecipe = false

        @State private var generatedRecipeTitles: [String] = []

        @State private var selectedRecipeTitle: IdentifiableString? = nil

        @State private var isPopupShown = false

        @State private var quantity = 1

    @State private var isDetectionPaused = false
    
    



    let apiKey = "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"



    var body: some View {

        ZStack {
            
            if isCameraActive {
                
                CameraView(detectedVegetables: $detectedVegetables,
                           
                           selectedVegetables: $selectedVegetables,
                           
                           isCameraActive: $isCameraActive,
                           
                           isPopupShown: $isPopupShown,
                           
                           quantity: $quantity
                           
                )
                // Pass isDetectionPaused
                
                .edgesIgnoringSafeArea(.all)
                
            }
            
            
            
            VStack {
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    
                    
                    Spacer()
                    
                }
                
                if !selectedVegetables.isEmpty {
                    
                    Text("Selected Vegetables: \(selectedVegetables.joined(separator: ", "))")
                    
                        .foregroundColor(.black)
                    
                        .padding(8)
                    
                        .background(Color.yellow)
                    
                        .cornerRadius(8)
                    
                        .padding(.top, 20)
                    
                }
                
                Button(action: {
                    fetchRecipeTitles(selectedCuisine: selectedPreferences.selectedCuisine, selectedMealType: selectedPreferences.selectedMealType)
                }) {
                    Text("Generate Recipe Titles")
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(red: 0.51, green: 0.73, blue: 0.71))
                        )
                }

                
                
            }
            
            
            
            // Show the quantity popup when isPopupShown is true
            
            // Show the quantity popup when isPopupShown is true
            
            if isPopupShown {
                            QuantityPopup(isShown: $isPopupShown, quantity: $quantity, vegetableName: detectedVegetables.last ?? "") {
                                // Empty closure as no specific action is needed when "Done" button is tapped
                            }
                        }



            

            // Present RecipeTitlesPage as a modal sheet covering more area

            if isRecipePopupVisible {

                NavigationView {

                    ZStack {

                        Color.clear // Clear background for navigation bar



                        // RecipeTitlesPage with background

                        VStack {

                            RecipeTitlesPage(recipeTitles: generatedRecipeTitles) { selectedTitle in

                                self.selectedRecipeTitle = IdentifiableString(value: selectedTitle)

                                generateRecipe()

                            }

                            .padding()

                            .background(.white)

                            .cornerRadius(10)

                            

                            .frame(maxWidth: .infinity)

                            .opacity(selectedRecipeTitle == nil ? 1 : 0)

                            .disabled(selectedRecipeTitle != nil)

                            .zIndex(1) // Ensure the RecipeTitlesPage is above other content

                        }



                        // Optional: Use a transparent overlay to cover the navigation bar area

                        Color.clear // Clear background for overlay

                            .edgesIgnoringSafeArea(.top) // Cover the navigation bar area

                            .frame(height: 0) // Optional: Hide the overlay

                    }

                    .navigationBarHidden(true) // Hide the navigation bar for RecipeTitlesPage

                    .transition(.opacity) // Optional: Apply transition for animation

                     // Optional: Apply animation

                }

                .frame(maxWidth: .infinity, maxHeight: .infinity)

            }





        }

        .overlay(

            Group {

                if isFetchingRecipe {

                    ProgressView()

                        .progressViewStyle(CircularProgressViewStyle())

                        .foregroundColor(.green)

                } else {

                    EmptyView()

                }

            }

        )

        .fullScreenCover(item: $selectedRecipeTitle) { title in
            NavigationView {
                RRecipeGeneratedPage(recipeTitle: title.value, selectedVegetablesWithQuantity: selectedVegetables.map { ($0, quantity) })
                    .navigationBarItems(leading: Button(action: {
                        // Set selectedRecipeTitle to nil when back button is tapped
                        resetState()
                    }) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    })
                    .onAppear {
                        isCameraActive = false
                    }
            }
        }






        .onAppear {

            resetState()

        }

    }





    private func resetState() {
            isRecipePopupVisible = false
            isFetchingRecipe = false
            generatedRecipeTitles = []
            selectedRecipeTitle = nil
            
        }


    private func fetchRecipeTitles(selectedCuisine: Cuisine?, selectedMealType: MealType?) {
        isFetchingRecipe = true
        // Use selectedCuisine and selectedMealType to generate prompts
        var prompt = "List down recipe titles(only title nothing else/extra) of 3-5 preferably Indian dishes not necessarily Indian, based on only and only the selected vegetables"
        if let cuisine = selectedCuisine {
            prompt += " and for \(cuisine.rawValue) cuisine only!"
        }
        if let mealType = selectedMealType {
            prompt += " for \(mealType.rawValue) time only!"
        }
        prompt += ", with the following quantities, if the quantity is 0 dont include it, do not show recipe titles which have any extra vegetable included please, only the vegetables mentioned and their quantity: \(selectedVegetables.map { "\($0) (\(quantity))" }.joined(separator: ", "))."
        
        sendPromptToChatGPT(prompt: prompt)
    }





    private func generateRecipe() {

        isCameraActive = true

        isFetchingRecipe = true

        let prompt = "Generate an existing step-by-step recipe only with the selected vegetables, respecting the quantities: \(selectedVegetables.map { "\($0) (\(quantity))" }.joined(separator: ", ")), nothing else. The recipe dish should have a name and should be tasty. You can consider that the user has some spices, wheat, and rice, and also Indian dishes will be preferred. Assume the user has no cooking experience."

        sendPromptToChatGPT(prompt: prompt)

    }





    private func sendPromptToChatGPT(prompt: String) {

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



        URLSession.shared.dataTask(with: request) { [self] (data, response, error) in

            isFetchingRecipe = false

            isCameraActive = true



            guard let data = data, error == nil else {

                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")

                return

            }



            if let responseString = String(data: data, encoding: .utf8) {

                print("Response: \(responseString)")

            }



            do {

                let decodedResponse = try JSONDecoder().decode(ChatGPTResponse.self, from: data)



                if !decodedResponse.choices.isEmpty {

                    let generatedRecipe = decodedResponse.choices[0].message.content

                    print("Generated Recipe: \(generatedRecipe)")



                    let recipeTitles = generatedRecipe.components(separatedBy: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }

                    generatedRecipeTitles = recipeTitles



                    DispatchQueue.main.async {

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



struct IdentifiableString: Identifiable {

    var id = UUID()

    var value: String

}



struct CameraView: UIViewControllerRepresentable {
    @Binding var detectedVegetables: [String]
    @Binding var selectedVegetables: [String]
    @Binding var isCameraActive: Bool
    @Binding var isPopupShown: Bool
    @Binding var quantity: Int
    
    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: CameraView
        
        init(parent: CameraView) {
            self.parent = parent
        }

        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            if let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
                do {
                    let model = try TasteWizOD(configuration: MLModelConfiguration())
                    let input = TasteWizODInput(image: pixelBuffer)
                    let output = try model.prediction(input: input)

                    let detectedVegetable = output.classLabel
                    let confidence = output.classLabelProbs[detectedVegetable] ?? 0.0

                    if confidence == 1.0 && !parent.selectedVegetables.contains(detectedVegetable) {
                        if detectedVegetable != "soy beans" && detectedVegetable != "raddish" && detectedVegetable != "paprika" {
                            DispatchQueue.main.async { [self] in
                                parent.detectedVegetables.append(detectedVegetable)
                                parent.selectedVegetables.append(detectedVegetable)
                                parent.isPopupShown = true // Update isPopupShown
                                parent.quantity = 1 // Reset quantity
                            }
                        }
                    }
                } catch {
                    print("Error performing inference: \(error)")
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
            Coordinator(parent: self)
        }

    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return viewController }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return viewController }
        captureSession.addInput(input)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        previewLayer.frame = viewController.view.bounds
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(context.coordinator as? AVCaptureVideoDataOutputSampleBufferDelegate, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        captureSession.startRunning()
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update UI if needed
    }
    
    // Popup view for quantity selection
    
    func quantityPopup() -> some View {
        if isPopupShown {
            return AnyView(QuantityPopup(isShown: $isPopupShown, quantity: $quantity, vegetableName: detectedVegetables.last ?? "") {
                // Set isDetectionPaused to false when "Done" button is tapped
                
            })
        } else {
            return AnyView(EmptyView())
        }
    }
}





struct RRecipeGeneratedPage: View, Identifiable {

    var id = UUID()

    var recipeTitle: String

    var selectedVegetablesWithQuantity: [(String, Int)] // Adjusted to include quantity

    let apiKey = "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"



    @State private var isFetchingRecipe = true

    @State private var generatedRecipe: String = ""



    var body: some View {

        NavigationView {

            ZStack {

                Color.white.edgesIgnoringSafeArea(.all)

                VStack {

                    if isFetchingRecipe {

                        ProgressView()

                            .progressViewStyle(CircularProgressViewStyle())

                            .foregroundColor(.green)

                            .padding()

                    } else {

                        ScrollView {

                            VStack(spacing: 20) {

                                Text("Step-by-Step Recipe")

                                    .font(.title)

                                    .fontWeight(.bold)

                                    .foregroundColor(Color(red: 0.51, green: 0.73, blue: 0.71))

                                    .padding(.top, 20)

                                

                                ForEach(generatedRecipe.components(separatedBy: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }, id: \.self) { step in

                                    RecipeStepView(step: step)

                                }

                                .padding(.horizontal)

                                

                                Text("Bon appétit")

                                    .font(.title)

                                    .fontWeight(.bold)

                                    .foregroundColor(Color(red: 0.51, green: 0.73, blue: 0.71))

                                    .padding(.top, 20)

                            }

                            .padding()

                        }

                        .navigationBarTitle(recipeTitle, displayMode: .inline)

                    }

                }

            }

            .onAppear {

                generateRecipe()

            }

        }

    }



    private func generateRecipe() {

        let formattedVegetables = selectedVegetablesWithQuantity.map { "\($0.0) (\($0.1))" }.joined(separator: ", ")

        let prompt = "Generate the recipe for \(recipeTitle) using only and only the selected vegetables, respecting the quantities: \(formattedVegetables), nothing extra. You can assume spices, rice, and flour are there with the user, and the user is very beginner, so explain everything in detail in a joyful way. You can use some Hindi slangs for better understanding and emojis."

        sendPromptToChatGPT(prompt: prompt)

    }



    private func sendPromptToChatGPT(prompt: String) {

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

        

        URLSession.shared.dataTask(with: request) { [self] (data, response, error) in

            isFetchingRecipe = false

            

            guard let data = data, error == nil else {

                print("Error: \(error?.localizedDescription ?? "Unknown error")")

                return

            }

            

            DispatchQueue.main.async {

                do {

                    let decodedResponse = try JSONDecoder().decode(ChatGPTResponse.self, from: data)

                    

                    if !decodedResponse.choices.isEmpty {

                        generatedRecipe = decodedResponse.choices[0].message.content

                    } else {

                        print("Empty response choices")

                    }

                } catch {

                    print("Error decoding response: \(error)")

                }

            }

        }.resume()

    }

}



struct RecipeStepView: View {

    var step: String

    

    var body: some View {

        HStack {

            Image(systemName: "circle.fill")

                .foregroundColor(Color(red: 0.51, green: 0.73, blue: 0.71))

                .font(.system(size: 10))

                .padding(.trailing, 5)

            

            Text(step)

                .font(.body)

                .foregroundColor(.black)

            

            Spacer()

        }

        .padding(.vertical, 5)

        .padding(.horizontal, 10)

        .background(Color.gray.opacity(0.1))

        .cornerRadius(10)

    }

}









struct RecipeResponse: Decodable {

    var choices: [Choice]

}









struct Choice: Codable {

    let text: String

}

struct ChatGPTResponse: Decodable {

    let choices: [ChatGPTChoice]

}



struct ChatGPTChoice: Decodable {

    let message: ChatGPTMessage

}



struct ChatGPTMessage: Decodable {

    let role: String

    let content: String

}

struct ChatGPTErrorResponse: Decodable {

    let error: ChatGPTError

}



struct ChatGPTError: Decodable {

    let message: String

    let type: String

    let param: String?

    let code: String

}

struct RecipeTitlesPage: View {

    var recipeTitles: [String]

    var onRecipeTitleSelected: (String) -> Void

    var body: some View {

        NavigationView {
            
            ScrollView {
                VStack(alignment: .center, spacing: 20) { // Changed to VStack for the additional text
                    
                    Text("Embark on a tasty journey! Choose your perfect recipe!") // Added punny text
                        .font(.title)
                        .foregroundColor(Color(red: 0.51, green: 0.73, blue: 0.71))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    LazyVStack(spacing: 16) {
                        
                        ForEach(recipeTitles, id: \.self) { title in
                            
                            Button(action: {
                                
                                onRecipeTitleSelected(title)
                                
                            }) {
                                
                                Text(title)
                                
                                    .font(.headline) // Increase font size
                                
                                    .padding()
                                
                                    .frame(maxWidth: .infinity)
                                
                                    .foregroundColor(.white)
                                
                                    .background(
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                        
                                            .foregroundColor(Color(red: 0.51, green: 0.73, blue: 0.71))
                                        
                                            .shadow(color: Color.black.opacity(0.7), radius: 5, x: 0, y: 2) // Adjust shadow color and radius
                                        
                                    )
                                
                            }
                            
                            .buttonStyle(PlainButtonStyle())
                            
                            .padding(.horizontal, 20) // Add horizontal padding
                            
                        }
                        
                    }
                    
                    .padding(.vertical, 20) // Add vertical padding
                    
                }
                
                 // Set navigation bar title
                
            }
        }

    }

}


struct QuantityPopup: View {
    @Binding var isShown: Bool
    @Binding var quantity: Int
    let vegetableName: String
    var onDone: () -> Void // Add closure for handling "Done" button tap

    var body: some View {
        if isShown {
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isShown = false
                        }
                    }

                VStack {
                    Text("Select quantity for \(vegetableName)")
                        .foregroundColor(.black)
                        .padding()

                    Stepper(value: $quantity, in: 0...50) {
                        Text("Quantity: \(quantity)")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .padding()

                    Button(action: {
                        withAnimation {
                            isShown = false
                        }
                        onDone() // Call the closure when "Done" button is tapped
                    }) {
                        Text("Done")
                            .foregroundColor(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green))
                    }
                    .padding()
                }
                .background(Color.white
                    .opacity(0.6) // Adjust opacity for the glass effect
                    .blur(radius: 13) )
                .cornerRadius(20)
                .padding()
            }
            .transition(.scale)
            .animation(.easeInOut)
        } else {
            EmptyView()
        }
    }
}
