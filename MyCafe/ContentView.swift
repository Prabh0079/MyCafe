import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State private var showSplash: Bool = true
    @State var sessionManager = SessionManager.shared
    
    var body: some View {
        ZStack {
                if sessionManager.isLoggedIn {
                    HomePage()
                        .transition(.opacity)
                } else {
                    SignIn()
                        .opacity(showSplash ? 0 : 1)
                }
                if showSplash {
                    Splashscreen()
                       
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        showSplash = false
                    }
                }
                checkAuthentication()
            }
    }
    
    func checkAuthentication() {
        if let user = Auth.auth().currentUser {
          
            sessionManager.loginUser(userId: user.uid) { success in
                if success {
                    print("Success")
                } else {
                    print("Not success")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
