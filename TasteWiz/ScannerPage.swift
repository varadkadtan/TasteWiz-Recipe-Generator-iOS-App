import SwiftUI

struct ScannerPage: View {
    @State private var showFloatingWindow = false // State variable to control visibility

    var body: some View {
      //  NavigationView {
            ZStack {
                // Your main content
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 442, height: 900)
                    .background(
                        Image("Image 4")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 442, height: 900)
                            .clipped()
                            .overlay(
                                ZStack {
                                   
                                    
                                    Button(action: {
                                        // Show/hide the floating window
                                        showFloatingWindow.toggle()
                                    }) {
                                        Image("Image 18") // Button Image
                                    }
                                    .offset(x: 0, y: 380) // Adjust position as needed
                                }
                            )
                    )
                    .cornerRadius(68)
                    .offset(y:-35)
                
                // Floating window
                if showFloatingWindow {
                    FloatingWindowView()
                        .frame(width: 5000, height: 850)
                        //.background(Color.white)
                        .cornerRadius(12)
                        .offset(x:0, y: 10) // Adjust position as needed
                }
            }
        }
    }


struct FloatingWindowView: View {
    var body: some View {
        // Your floating window content
        RecipeGeneratedPage()
    }
}

struct ScannerPage_Previews: PreviewProvider {
    static var previews: some View {
        ScannerPage()
    }
}
