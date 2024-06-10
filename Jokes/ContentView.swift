//
//  ContentView.swift
//  Jokes
//
//  Created by Kelvin on 6/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var jokeText = "Click Button"
    
    var body: some View {
        VStack {
            Spacer()
            Text(jokeText)
            Spacer()
            Button {
                getJoke()
            } label: {
                Text("Get Random Joke")
            }
        }
        .padding()
    }
    
    func getJoke() {
        Task {
            if let url = URL(string: "https://v2.jokeapi.dev/joke/Any?type=single") {
                do {
                    // Make the API call
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    // Parse the JSON data
                    let decoder = JSONDecoder()
                    let joke = try decoder.decode(Joke.self, from: data)
                    
                    // Assign joke text to label
                    jokeText = joke.joke
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
