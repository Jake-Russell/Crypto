//
//  PortfolioChartView.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import SwiftUI

struct PortfolioChartView: View {
    @EnvironmentObject var vm: HomeViewModel
    @Binding var showPortfolioChartView: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background.ignoresSafeArea()

                List {
                    allHoldingsSection
                    
                    ForEach(vm.portfolioCoins) { coin in
                        PortfolioDetailRowView(coin: coin)
                    }
                    
                }

                .navigationTitle("My Portfolio - \(vm.portfolioValue.asCurrencyWith2Decimals())")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        XMarkButton(showSheet: $showPortfolioChartView)
                    }
                }
            }
        }
    }
}

struct PortfolioChartView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioChartView(showPortfolioChartView: .constant(true))
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioChartView {
    private var allHoldingsSection: some View {
        Section(header: Text("All Holdings")) {
            VStack(alignment: .leading) {
                Text("Current Investments")
                    .fontWeight(.bold)
                HStack {
                    Text(vm.totalGBPInvestments.asCurrencyWith2Decimals())
                    Spacer()
                    Text(vm.portfolioValueInvestments.asCurrencyWith2Decimals()).foregroundColor((vm.portfolioValueInvestments - vm.totalGBPInvestments) >= 0 ? Color.theme.green : Color.theme.red)
                    Spacer()
                    Text("\((vm.portfolioValueInvestments - vm.totalGBPInvestments) >= 0 ? "+" : "")\((vm.portfolioValueInvestments - vm.totalGBPInvestments).asCurrencyWith2Decimals()) (\(((vm.portfolioValueInvestments - vm.totalGBPInvestments) / vm.portfolioValueInvestments * 100).asPercentString()))")
                        .foregroundColor((vm.portfolioValue - vm.totalGBPInvestments) >= 0 ? Color.theme.green : Color.theme.red)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Current Holdings")
                    .fontWeight(.bold)
                HStack {
                    Text(vm.portfolioValue.asCurrencyWith2Decimals())
                    Spacer()
                    Text("\((vm.portfolioValue - vm.totalGBPInvestments) >= 0 ? "+" : "")\((vm.portfolioValue - vm.totalGBPInvestments).asCurrencyWith2Decimals()) (\(((vm.portfolioValue - vm.totalGBPInvestments) / vm.portfolioValue * 100).asPercentString()))")
                        .foregroundColor((vm.portfolioValue - vm.totalGBPInvestments) >= 0 ? Color.theme.green : Color.theme.red)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (1h)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (vm.percentagePortfolioChange1H ) >= 0 ? 0 : 180))
                    Text("\(vm.percentagePortfolioChange1H.asPercentString() ) ")
                    Spacer()
                    VStack {
                        Text("\(vm.differencePortfolioValue1H >= 0 ? "+" : "")\(vm.differencePortfolioValue1H.asCurrencyWith2Decimals())")
                        Text(vm.previousPortfolioValue1H.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(vm.differencePortfolioValue1H >= 0 ? Color.theme.green : Color.theme.red)
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (24h)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (vm.percentagePortfolioChange24H ) >= 0 ? 0 : 180))
                    Text("\(vm.percentagePortfolioChange24H.asPercentString() ) ")
                    Spacer()
                    VStack {
                        Text("\(vm.differencePortfolioValue24H >= 0 ? "+" : "")\(vm.differencePortfolioValue24H.asCurrencyWith2Decimals())")
                        Text(vm.previousPortfolioValue24H.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(vm.differencePortfolioValue24H >= 0 ? Color.theme.green : Color.theme.red)
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (7d)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (vm.percentagePortfolioChange7D ) >= 0 ? 0 : 180))
                    Text("\(vm.percentagePortfolioChange7D.asPercentString() ) ")
                    Spacer()
                    VStack {
                        Text("\(vm.differencePortfolioValue7D >= 0 ? "+" : "")\(vm.differencePortfolioValue7D.asCurrencyWith2Decimals())")
                        Text(vm.previousPortfolioValue7D.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(vm.differencePortfolioValue7D >= 0 ? Color.theme.green : Color.theme.red)
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (14d)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (vm.percentagePortfolioChange14D) >= 0 ? 0 : 180))
                    Text("\(vm.percentagePortfolioChange14D.asPercentString() ) ")
                    Spacer()
                    VStack {
                        Text("\(vm.differencePortfolioValue14D >= 0 ? "+" : "")\(vm.differencePortfolioValue14D.asCurrencyWith2Decimals())")
                        Text(vm.previousPortfolioValue14D.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(vm.differencePortfolioValue14D >= 0 ? Color.theme.green : Color.theme.red)
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (30d)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (vm.percentagePortfolioChange30D) >= 0 ? 0 : 180))
                    Text("\(vm.percentagePortfolioChange30D.asPercentString() ) ")
                    Spacer()
                    VStack {
                        Text("\(vm.differencePortfolioValue30D >= 0 ? "+" : "")\(vm.differencePortfolioValue30D.asCurrencyWith2Decimals())")
                        Text(vm.previousPortfolioValue30D.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(vm.differencePortfolioValue30D >= 0 ? Color.theme.green : Color.theme.red)
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (1y)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (vm.percentagePortfolioChange1Y) >= 0 ? 0 : 180))
                    Text("\(vm.percentagePortfolioChange1Y.asPercentString() ) ")
                    Spacer()
                    VStack {
                        Text("\(vm.differencePortfolioValue1Y >= 0 ? "+" : "")\(vm.differencePortfolioValue1Y.asCurrencyWith2Decimals())")
                        Text(vm.previousPortfolioValue1Y.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(vm.differencePortfolioValue1Y >= 0 ? Color.theme.green : Color.theme.red)
            }
        }
    }
}
