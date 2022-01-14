//
//  PortfolioView.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import SwiftUI

struct PortfolioView: View {
    
    @Binding var showPortfolioView: Bool
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var investmentText: String = ""
    @State private var showCheckmark: Bool = false
        
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(showSheet: $showPortfolioView)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                }
            }
            .onChange(of: vm.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(showPortfolioView: .constant(true))
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                            UIApplication.shared.endEditing()
                        }
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1))
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let investment = portfolioCoin.currentGBPInvestments {
            investmentText = "\(investment)"
        } else {
            investmentText = ""
        }
    
        
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount Holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Amount Invested:")
                Spacer()
                TextField("Ex: 50", text: $investmentText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity((selectedCoin != nil) && (selectedCoin?.currentHoldings != Double(quantityText)) || (selectedCoin?.currentGBPInvestments != Double(investmentText)) ? 1.0 : 0.0)
        }
        .font(.headline)
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText),
            let investment = Double(investmentText)
            else { return }
        
        // Save to Portfolio
        vm.updatePortfolio(coin: coin, amount: amount, currentGBPInvestment: investment)
        
        // Show Checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // Hide Keyboard
        UIApplication.shared.endEditing()
        
        // Hide Checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
