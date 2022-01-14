//
//  PortfolioDetailRowView.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import SwiftUI

struct PortfolioDetailRowView: View {
    let coin: CoinModel
    
    var body: some View {
        let previousValue1h = calculatePreviousValue(currentHoldingsValue: coin.currentHoldingsValue, percentageChange: coin.priceChangePercentage1HInCurrency ?? 1)
        
        let previousValue24h = calculatePreviousValue(currentHoldingsValue: coin.currentHoldingsValue, percentageChange: coin.priceChangePercentage24HInCurrency ?? 1)
        
        let previousValue7d = calculatePreviousValue(currentHoldingsValue: coin.currentHoldingsValue, percentageChange: coin.priceChangePercentage7DInCurrency ?? 1)
        
        let previousValue14d = calculatePreviousValue(currentHoldingsValue: coin.currentHoldingsValue, percentageChange: coin.priceChangePercentage14DInCurrency ?? 1)
        
        let previousValue30d = calculatePreviousValue(currentHoldingsValue: coin.currentHoldingsValue, percentageChange: coin.priceChangePercentage30DInCurrency ?? 1)
        
        let previousValue1y = calculatePreviousValue(currentHoldingsValue: coin.currentHoldingsValue, percentageChange: coin.priceChangePercentage1YInCurrency ?? 1)

        let difference1h = coin.currentHoldingsValue - previousValue1h
        let difference24h = coin.currentHoldingsValue - previousValue24h
        let difference7d = coin.currentHoldingsValue - previousValue7d
        let difference14d = coin.currentHoldingsValue - previousValue14d
        let difference30d = coin.currentHoldingsValue - previousValue30d
        let difference1y = coin.currentHoldingsValue - previousValue1y

        Section(header: Text(coin.name)){
            HStack() {
                CoinImageView(coin: coin)
                    .frame(width: 50, height: 50)
                Spacer()
                Text(coin.currentPrice.asCurrencyWith2Decimals())
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("Holdings")
                        .fontWeight(.bold)
                    Spacer()
                    Text("Investments")
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                    Spacer()
                    Text(coin.currentGBPInvestments?.asCurrencyWith2Decimals() ?? "£0.00")
                }
                
                HStack {
                    Text("\(coin.currentHoldings ?? 0) \(coin.symbol.uppercased())")
                        .foregroundColor(Color.theme.secondaryText)
                    .italic()
                    Spacer()
                    Text("\((coin.currentHoldingsValue - (coin.currentGBPInvestments ?? 0)) >= 0 ? "+" : "")\((coin.currentHoldingsValue - (coin.currentGBPInvestments ?? 0)).asCurrencyWith2Decimals()) (\(((coin.currentHoldingsValue - (coin.currentGBPInvestments ?? 0)) / coin.currentHoldingsValue * 100).asPercentString()))")
                        .foregroundColor((coin.currentHoldingsValue - (coin.currentGBPInvestments ?? 0)) >= 0 ? Color.theme.green : Color.theme.red)
                }
            }
            
            
            VStack(alignment: .leading) {
                Text("Value Change (1h)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (coin.priceChangePercentage1HInCurrency ?? 0 ) >= 0 ? 0 : 180))
                    Text("\(coin.priceChangePercentage1HInCurrency?.asPercentString() ?? "n/a") ")
                    Spacer()
                    VStack {
                        Text("\(difference1h >= 0 ? "+" : "")\(difference1h.asCurrencyWith2Decimals())")
                        Text(previousValue1h.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(difference1h >= 0 ? Color.theme.green : Color.theme.red)
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (24h)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (coin.priceChangePercentage24HInCurrency ?? 0 ) >= 0 ? 0 : 180))
                    Text("\(coin.priceChangePercentage24HInCurrency?.asPercentString() ?? "n/a") ")
                    Spacer()
                    VStack {
                        Text("\(difference24h >= 0 ? "+" : "")\(difference24h.asCurrencyWith2Decimals())")
                        Text(previousValue24h.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(difference24h >= 0 ? Color.theme.green : Color.theme.red)
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (7d)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (coin.priceChangePercentage7DInCurrency ?? 0 ) >= 0 ? 0 : 180))
                    Text("\(coin.priceChangePercentage7DInCurrency?.asPercentString() ?? "n/a") ")
                    Spacer()
                    VStack {
                        Text("\(difference7d >= 0 ? "+" : "")\(difference7d.asCurrencyWith2Decimals())")
                        Text(previousValue7d.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(difference7d >= 0 ? Color.theme.green : Color.theme.red)
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (14d)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (coin.priceChangePercentage14DInCurrency ?? 0 ) >= 0 ? 0 : 180))
                    Text("\(coin.priceChangePercentage14DInCurrency?.asPercentString() ?? "n/a") ")
                    Spacer()
                    VStack {
                        Text("\(difference14d >= 0 ? "+" : "")\(difference14d.asCurrencyWith2Decimals())")
                        Text(previousValue14d.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(difference14d >= 0 ? Color.theme.green : Color.theme.red)
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (30d)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (coin.priceChangePercentage30DInCurrency ?? 0 ) >= 0 ? 0 : 180))
                    Text("\(coin.priceChangePercentage30DInCurrency?.asPercentString() ?? "n/a") ")
                    Spacer()
                    VStack {
                        Text("\(difference30d >= 0 ? "+" : "")\(difference30d.asCurrencyWith2Decimals())")
                        Text(previousValue30d.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(difference30d >= 0 ? Color.theme.green : Color.theme.red)
            }
            
            VStack(alignment: .leading) {
                Text("Value Change (1y)")
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (coin.priceChangePercentage1YInCurrency ?? 0 ) >= 0 ? 0 : 180))
                    Text("\(coin.priceChangePercentage1YInCurrency?.asPercentString() ?? "n/a") ")
                    Spacer()
                    VStack {
                        Text("\(difference1y >= 0 ? "+" : "")\(difference1y.asCurrencyWith2Decimals())")
                        Text(previousValue1y.asCurrencyWith2Decimals())
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                    }
                }
                .foregroundColor(difference1y >= 0 ? Color.theme.green : Color.theme.red)
            }
        }
    }
}

struct PortfolioDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioDetailRowView(coin: dev.coin)
    }
}

private func calculatePreviousValue(currentHoldingsValue: Double, percentageChange: Double) -> Double {
    return currentHoldingsValue / (1 + (percentageChange / 100))
}
