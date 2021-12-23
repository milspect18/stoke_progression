//
//  HomeView.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/19/21.
//

import SwiftUI

struct HomeView: View {
    static let tag: String? = "home"
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add Data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
            }
            .navigationTitle("Home")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
