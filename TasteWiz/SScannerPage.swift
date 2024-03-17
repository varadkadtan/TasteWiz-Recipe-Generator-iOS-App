import SwiftUI
import AVFoundation
import CoreML
import AVKit

struct SScannerPage: View {
    @State private var isRecipePopupVisible = false
    @State private var detectedVegetables: [String] = []
    @State private var selectedVegetables: [String] = []
    @State private var generatedRecipe: String = ""
    @State private var isCameraActive = true
    @State private var isFetchingRecipe = false
    @State private var generatedRecipeTitles: [String] = []
    @State private var selectedRecipeTitle: IdentifiableString? = nil

    let apiKey = ""

    var body: some View {
        ZStack {
            if isCameraActive {
                CameraView(detectedVegetables: $detectedVegetables, selectedVegetables: $selectedVegetables, isCameraActive: $isCameraActive)
                    .edgesIgnoringSafeArea(.all)
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        ForEach(detectedVegetables, id: \.self) { vegetable in
                            Text(vegetable)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
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
                    fetchRecipeTitles()
                }) {
                    Text("Generate Recipe Titles")
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.green)
                        )
                }
            }
            
            // Present RecipeTitlesPage as a modal sheet covering more area
            if isRecipePopupVisible {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all) // Background overlay
                VStack {
                    RecipeTitlesPage(recipeTitles: generatedRecipeTitles) { selectedTitle in
                        self.selectedRecipeTitle = IdentifiableString(value: selectedTitle)
                        generateRecipe()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(maxWidth: .infinity)
                    .opacity(selectedRecipeTitle == nil ? 1 : 0)
                    .disabled(selectedRecipeTitle != nil)
                    .zIndex(1) // Ensure the RecipeTitlesPage is above other content
                    Spacer()
                }
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
        .sheet(item: $selectedRecipeTitle) { title in
            RRecipeGeneratedPage(recipeTitle: title.value, selectedVegetables: selectedVegetables)
                .onDisappear {
                    isRecipePopupVisible = false
                }
                .onAppear {
                    isCameraActive = false
                }
        }
        .onAppear {
            resetState()
        }
    
    }

    private func resetState() {
        isFetchingRecipe = false
        generatedRecipeTitles = []
        selectedRecipeTitle = nil
    }

    private func fetchRecipeTitles() {
        isCameraActive = true
        isFetchingRecipe = true
        let prompt = "List down 3-5 preferrably Indian recipe titles based on only and only the selected vegetables, you can assume user has some spices, wheat flour and rice: \(selectedVegetables.joined(separator: ", "))."
        sendPromptToChatGPT(prompt: prompt)
    }

    private func generateRecipe() {
        isCameraActive = true
        isFetchingRecipe = true
        let prompt = "Generate a existing step by step recipe only with the selected vegetables: \(selectedVegetables.joined(separator: ", ")) nothing else, and it is not necessary to use all but the recipe dish should have a name and should be tasty, you can consider that the user has some spices and also wheat and rice , and also indian dishes will be preferred, assume the user has no cooking experience"
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

                    if confidence == 1.0 {
                        DispatchQueue.main.async { [self] in
                            if !detectedVegetable.isEmpty && !parent.detectedVegetables.contains(detectedVegetable) {
                                parent.detectedVegetables.append(detectedVegetable)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                                    if let index = parent.detectedVegetables.firstIndex(of: detectedVegetable) {
                                        parent.detectedVegetables.remove(at: index)
                                    }
                                }
                                parent.selectedVegetables.append(detectedVegetable)
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
}

struct RRecipeGeneratedPage: View, Identifiable {
    var id = UUID()
    var recipeTitle: String
    var selectedVegetables: [String]
    let apiKey = ""

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
                                    .foregroundColor(.blue)
                                    .padding(.top, 20)
                                
                                ForEach(generatedRecipe.components(separatedBy: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }, id: \.self) { step in
                                    RecipeStepView(step: step)
                                }
                                .padding(.horizontal)
                                
                                Text("Bon appétit")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
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
        let prompt = "Generate the recipe for \(recipeTitle) using only and only the selected vegetables nothing extra, you can assume spices rice and flour is there with the user, and also user is very beginner so explain him everything in detail in a joyous way, you can use some Hindi slangs for better understanding also emojis: \(selectedVegetables.joined(separator: ", "))."
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
                .foregroundColor(.blue)
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
                LazyVStack(spacing: 16) {
                    ForEach(recipeTitles, id: \.self) { title in
                        Button(action: {
                            onRecipeTitleSelected(title)
                        }) {
                            Text(title)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.blue)
                                        .shadow(color: .gray, radius: 3, x: 0, y: 2)
                                )
                                .foregroundColor(.white)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Recipe Titles")
        }
    }
}
