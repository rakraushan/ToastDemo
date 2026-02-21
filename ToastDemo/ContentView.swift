//
//  ContentView.swift
//  ToastDemo
//
//  Created by Raushan, Rakesh Kumar on 21/02/26.
//

import SwiftUI
import ToastKit

struct ContentView: View {
    
    @State private var activeToasts: [Toast] = []
    @State private var eventLog: [String] = []
    @State private var customMessage: String = ""
    
    private let observer = AppToastObserver()
    
    var body: some View {
        ZStack {
            // Main Content
            VStack(spacing: 20) {
                
                // Title
                Text("🍞 Toast Demo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Text("Tap buttons to show toasts")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                    .padding(.vertical)
                
                // Quick Action Buttons
                VStack(spacing: 16) {
                    ToastButton(
                        title: "✅ Success Toast",
                        color: .green
                    ) {
                        ToastManager.shared.success("Operation completed successfully!")
                    }
                    
                    ToastButton(
                        title: "❌ Error Toast",
                        color: .red
                    ) {
                        ToastManager.shared.error("Something went wrong!")
                    }
                    
                    ToastButton(
                        title: "⚠️ Warning Toast",
                        color: .orange
                    ) {
                        ToastManager.shared.warning("Please check your input")
                    }
                    
                    ToastButton(
                        title: "ℹ️ Info Toast",
                        color: .blue
                    ) {
                        ToastManager.shared.info("Here's some useful information")
                    }
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.vertical)
                
                // Custom Message
                VStack(spacing: 12) {
                    TextField("Enter custom message", text: $customMessage)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    Button {
                        if !customMessage.isEmpty {
                            ToastManager.shared.info(customMessage)
                            customMessage = ""
                        }
                    } label: {
                        Text("Show Custom Toast")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                    .padding(.vertical)
                
                // Event Log
                VStack(alignment: .leading, spacing: 8) {
                    Text("Event Log:")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(eventLog.prefix(8), id: \.self) { event in
                                Text(event)
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .frame(height: 120)
                    .background(Color(.systemGray))
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Clear All Button
                if !activeToasts.isEmpty {
                    Button {
                        ToastManager.shared.dismissAll()
                    } label: {
                        Text("Clear All Toasts")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    .padding(.bottom)
                }
            }
            
            // Toast Overlay
            ToastOverlay(toasts: $activeToasts)
        }
        .onAppear {
            setupToastKit()
        }
    }
    
    private func setupToastKit() {
        print("🔧 Setting up ToastKit...")
        
        // Configure with dependencies
        ToastManager.shared.configure(
            configProvider: AppToastConfiguration(),
            styleProvider: AppToastStyle(),
            eventObserver: observer
        )
        
        // Setup observer callback
        observer.onToastUpdate = { [self] in
            updateToasts()
        }
        
        print("✅ ToastKit ready!")
        
        // Show welcome toast
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ToastManager.shared.success("Welcome to Toast Demo!")
        }
    }
    
    private func updateToasts() {
        activeToasts = ToastManager.shared.getActiveToasts()
        
        // Add to event log
        let timestamp = DateFormatter.localizedString(
            from: Date(),
            dateStyle: .none,
            timeStyle: .medium
        )
        eventLog.insert("[\(timestamp)] Toast count: \(activeToasts.count)", at: 0)
    }
}

// MARK: - Toast Button

struct ToastButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .cornerRadius(12)
        }
    }
}

// MARK: - Toast Overlay

struct ToastOverlay: View {
    @Binding var toasts: [Toast]
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(toasts) { toast in
                ToastView(toast: toast)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            Spacer()
        }
        .padding(.top, 50)
        .padding(.horizontal)
        .animation(.spring(), value: toasts.count)
    }
}

// MARK: - Individual Toast View

struct ToastView: View {
    let toast: Toast
    
    var body: some View {
        let style = ToastManager.shared.getStyle(for: toast.type)
        
        HStack(spacing: 12) {
            // Icon
            if let iconName = style.icon {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(colorFromToastColor(style.text))
            }
            
            // Message
            Text(toast.message)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(colorFromToastColor(style.text))
            
            Spacer()
            
            // Dismiss button
            Button {
                ToastManager.shared.dismiss(toast: toast)
            } label: {
                Image(systemName: "xmark")
                    .font(.caption)
                    .foregroundColor(colorFromToastColor(style.text).opacity(0.7))
            }
        }
        .padding()
        .background(colorFromToastColor(style.background))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        .onTapGesture {
            ToastManager.shared.handleTap(toast: toast)
        }
    }
    
    private func colorFromToastColor(_ toastColor: ToastColor) -> Color {
        return Color(
            red: toastColor.red,
            green: toastColor.green,
            blue: toastColor.blue,
            opacity: toastColor.alpha
        )
    }
}

#Preview {
    ContentView()
}
