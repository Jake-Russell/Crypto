//
//  SettingsView.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettingsView: Bool
    let websiteURL = URL(string: "https://www.jakerussell.photography")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                
                List {
                    jakeRussellPhotographySection
                    coinGeckoSection
                }
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        XMarkButton(showSheet: $showSettingsView)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsView: .constant(false))
    }
}

extension SettingsView {
    private var jakeRussellPhotographySection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by Jake Russell. It uses a MVVM Architecture, Combine and CoreData.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Checkout my Website", destination: websiteURL)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko", destination: coingeckoURL)
                .foregroundColor(Color.theme.accent)
        }
    }
}
