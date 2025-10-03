//
//  AuthView.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/15/25.
//


import SwiftUI

struct AuthView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("AppBlack").ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Logo / Header
                    Image("CABA_Logo_Final")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                    Text("Welcome Back")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(0.9)
                    
                    // Card: Sign In fields
                    VStack(spacing: 14) {
                        HStack(spacing: 10) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.blue.opacity(0.9))
                            TextField("Username", text: $username)
                                .foregroundColor(.white)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                        }
                        .padding()
                        .background(Color.white.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack(spacing: 10) {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.blue.opacity(0.9))
                            SecureField("Password", text: $password)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal, 28)
                    
                    // Sign In Button
                    Button {
                        if !username.isEmpty && !password.isEmpty {
                            isLoggedIn = true
                        }
                    } label: {
                        Text("Sign In")
                            .font(.headline.bold())
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .blue.opacity(0.35), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 28)
                    .padding(.top, 6)
                    
                    // Full blue link to Sign Up
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Don’t have an account? Sign Up")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .padding(.top, 4)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer(minLength: 20)
                }
            }
        }
    }
}

struct SignUpView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var email: String = "" // Optional
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showMismatchAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color("AppBlack").ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("Create Account")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                // Card: Sign Up fields
                VStack(spacing: 14) {
                    // First Name
                    HStack(spacing: 10) {
                        Image(systemName: "textformat")
                            .foregroundColor(.blue.opacity(0.9))
                        TextField("First Name", text: $firstName)
                            .foregroundColor(.white)
                            .textInputAutocapitalization(.words)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Last Name
                    HStack(spacing: 10) {
                        Image(systemName: "textformat")
                            .foregroundColor(.blue.opacity(0.9))
                        TextField("Last Name", text: $lastName)
                            .foregroundColor(.white)
                            .textInputAutocapitalization(.words)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Username
                    HStack(spacing: 10) {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(.blue.opacity(0.9))
                        TextField("Username", text: $username)
                            .foregroundColor(.white)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Optional Email
                    HStack(spacing: 10) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue.opacity(0.9))
                        TextField("Email (optional, for password reset)", text: $email)
                            .foregroundColor(.white)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Password
                    HStack(spacing: 10) {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.blue.opacity(0.9))
                        SecureField("Password", text: $password)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Confirm Password
                    HStack(spacing: 10) {
                        Image(systemName: "lock.rotation.open")
                            .foregroundColor(.blue.opacity(0.9))
                        SecureField("Confirm Password", text: $confirmPassword)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 28)
                
                // Sign Up Button
                Button {
                    guard !username.isEmpty, !password.isEmpty else { return }
                    if password == confirmPassword {
                        isLoggedIn = true
                    } else {
                        showMismatchAlert = true
                    }
                } label: {
                    Text("Sign Up")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .blue.opacity(0.35), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 28)
                .alert("Passwords don’t match", isPresented: $showMismatchAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Please make sure your password and confirmation match.")
                }
                
                Spacer(minLength: 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    AuthView()
}
