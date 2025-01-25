import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Spacer()
                    .frame(height: 20)
                Text("Hello, world!")
                Spacer()
                    .frame(height: 20)
                Text("What a beautiful day it is! :)")
                Spacer()
                NavigationLink(destination: SecondView()) {
                    Text("Go to Second Screen")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .navigationTitle("Home")
                Spacer()
            }
            .padding()
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to the second screen!")
            Spacer()
            Text("Here is some more text to display.")
            Text("Enjoy your time here :)")
            Spacer()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
