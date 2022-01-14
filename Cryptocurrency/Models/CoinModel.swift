//
//  CoinModel.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import Foundation

// CoinGecko API Info
/*

 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=GBP&order=market_cap_desc&per_page=10&page=1&sparkline=true&price_change_percentage=24h
 
 JSON Response:
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
     "current_price": 40445,
     "market_cap": 765006587962,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 850745262701,
     "total_volume": 30120926919,
     "hcigh_24h": 44671,
     "low_24h": 40434,
     "price_change_24h": -3191.499635205568,
     "price_change_percentage_24h": -7.31388,
     "market_cap_change_24h": -56238314118.20996,
     "market_cap_change_percentage_24h": -6.84793,
     "circulating_supply": 18883606,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 51032,
     "ath_change_percentage": -20.61518,
     "ath_date": "2021-11-10T14:24:11.849Z",
     "atl": 43.9,
     "atl_change_percentage": 92177.10497,
     "atl_date": "2013-07-05T00:00:00.000Z",
     "roi": null,
     "last_updated": "2021-11-26T12:05:26.939Z",
     "sparkline_in_7d": {
       "price": [
         56909.752711635825,
         57191.27367906288,
         .....
       ]
     },
     "price_change_percentage_24h_in_currency": -7.3138810686942595
   }
*/

struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency, priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage1YInCurrency: Double?
    let currentHoldings: Double?
    let currentGBPInvestments: Double?
    
    enum CodingKeys: String, CodingKey {
            case id, symbol, name, image
            case currentPrice = "current_price"
            case marketCap = "market_cap"
            case marketCapRank = "market_cap_rank"
            case fullyDilutedValuation = "fully_diluted_valuation"
            case totalVolume = "total_volume"
            case high24H = "high_24h"
            case low24H = "low_24h"
            case priceChange24H = "price_change_24h"
            case priceChangePercentage24H = "price_change_percentage_24h"
            case marketCapChange24H = "market_cap_change_24h"
            case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
            case circulatingSupply = "circulating_supply"
            case totalSupply = "total_supply"
            case maxSupply = "max_supply"
            case ath
            case athChangePercentage = "ath_change_percentage"
            case athDate = "ath_date"
            case atl
            case atlChangePercentage = "atl_change_percentage"
            case atlDate = "atl_date"
            case lastUpdated = "last_updated"
            case sparklineIn7D = "sparkline_in_7d"
            case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
            case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
            case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
            case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
            case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
            case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
            case currentHoldings
            case currentGBPInvestments
        }
    
    func updateHoldings(amount: Double, currentGBPInvestments: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage1HInCurrency: priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: priceChangePercentage7DInCurrency, priceChangePercentage14DInCurrency: priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency: priceChangePercentage30DInCurrency, priceChangePercentage1YInCurrency: priceChangePercentage1YInCurrency, currentHoldings: amount, currentGBPInvestments: currentGBPInvestments)
        }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
