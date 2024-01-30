//
//  ContentView.swift
//  HomeKitDemo
//
//  Created by Angelos Staboulis on 30/1/24.
//

import SwiftUI
import HomeKit
struct ContentView: View {
    @State var manager = HMHomeManager()
    @State var homes:[String] = ["Home-Komotini","Home-Xanthi","Home-Kavala","Home-Alexandroupoli"]
    @State var pressed:Bool
    var body: some View {
        NavigationStack{
            List(pressed ? homes : [],id:\.self){ item in
                Text(item)
            }.toolbar(content: {
                Menu("Home Menu") {
                    Button {
                        pressed.toggle()
                        createHomes()
                       
                    } label: {
                        Text("Create Homes")
                    }
                    Button {
                        removeHomes()
                        pressed.toggle()
                    } label: {
                        Text("Remove Homes")
                    }
                }
               
            }).navigationTitle("HomeKitDemo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func removeHomes(){
        var getHomes = manager.homes
        for home in getHomes{
            manager.removeHome(home) { error in}
        }
       
    }
    func createHomes(){
        for home in homes {
            manager.addHome(withName: home) { home, error in}
        }
    }
}

#Preview {
    ContentView(pressed: false)
}
