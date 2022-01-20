//
//  AwardsView.swift
//  StokeProgresion
//
//  Created by Kyle Price on 1/19/22.
//

import SwiftUI

struct AwardsView: View {
    @EnvironmentObject var dataController: DataController
    
    @State private var selectedAward = Award.example
    @State private var showingAwardDetails = false
    
    static let tag: String? = "Awards"
    
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            selectedAward = award
                            showingAwardDetails = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(awardImageColor(for: award))
                        }
                    }
                }
            }
            .navigationTitle("Awards")
        }
        .alert(alertTitle(for: selectedAward), isPresented: $showingAwardDetails) {
            Button("Ok") { showingAwardDetails = false }
        } message: {
            Text(selectedAward.description)
        }

    }
    
    func awardImageColor(for award: Award) -> Color {
        return dataController.hasEarned(award: award) ? Color(award.color) : .secondary.opacity(0.5)
    }
    
    func alertTitle(for award: Award) -> String {
        dataController.hasEarned(award: selectedAward) ? "Unlocked: \(award.name)" : "Locked"
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
    }
}
