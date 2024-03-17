//
//  KeyboardAwareModifier.swift
//  TasteWiz
//
//  Created by Admin on 01/03/24.
//

import Foundation
import SwiftUI
import Combine

// Define the KeyboardAwareModifier
struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .edgesIgnoringSafeArea(keyboardHeight > 0 ? .bottom : [])
            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}

// Create extension to get keyboard height
extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

// Add extension to get keyboard height
extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

// Usage example:
// struct ContentView: View {
//     @State private var text: String = ""
//
//     var body: some View {
//         TextField("Enter text", text: $text)
//             .padding()
//             .modifier(KeyboardAwareModifier())
//     }
// }
