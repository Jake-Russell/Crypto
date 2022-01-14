//
//  HomeViewModel.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    @Published var totalGBPInvestments: Double = 0
    
    @Published var portfolioValue: Double = 0
    @Published var portfolioValueInvestments: Double = 0
    @Published var previousPortfolioValue1H: Double = 0
    @Published var previousPortfolioValue24H: Double = 0
    @Published var previousPortfolioValue7D: Double = 0
    @Published var previousPortfolioValue14D: Double = 0
    @Published var previousPortfolioValue30D: Double = 0
    @Published var previousPortfolioValue1Y: Double = 0
    
    @Published var percentagePortfolioChange1H: Double = 0
    @Published var percentagePortfolioChange24H: Double = 0
    @Published var percentagePortfolioChange7D: Double = 0
    @Published var percentagePortfolioChange14D: Double = 0
    @Published var percentagePortfolioChange30D: Double = 0
    @Published var percentagePortfolioChange1Y: Double = 0
    
    @Published var differencePortfolioValue1H: Double = 0
    @Published var differencePortfolioValue24H: Double = 0
    @Published var differencePortfolioValue7D: Double = 0
    @Published var differencePortfolioValue14D: Double = 0
    @Published var differencePortfolioValue30D: Double = 0
    @Published var differencePortfolioValue1Y: Double = 0
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // Updates All Coins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Updates Portfolio Coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // Updates Market Data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double, currentGBPInvestment: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount, currentGBPInvestment: currentGBPInvestment)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        hapticFeedback(type: .success)
    }
    
    func hapticFeedback(type: UINotificationFeedbackGenerator.FeedbackType) {
        HapticManager.notification(type: type)
    }
    
    private func filterAndSortCoins (text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // Will only sort by holdings or reversedHolidngs if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercaseText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercaseText) ||
            coin.symbol.lowercased().contains(lowercaseText) ||
            coin.id.lowercased().contains(lowercaseText)
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        totalGBPInvestments = 0
        return allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                totalGBPInvestments += entity.currentGBPInvestment
                return coin.updateHoldings(amount: entity.amount, currentGBPInvestments: entity.currentGBPInvestment)
            }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        
        portfolioValue = portfolioCoins
                .map({ $0.currentHoldingsValue })
                .reduce(0, +)
        
        let investedBTC = portfolioCoins.first(where: { $0.id == "bitcoin"})
        let investedETH = portfolioCoins.first(where: { $0.id == "ethereum"})
        portfolioValueInvestments = (investedBTC?.currentHoldingsValue ?? 0) + (investedETH?.currentHoldingsValue ?? 0)
        NSLog(portfolioValueInvestments.asCurrencyWith2Decimals())
        
        previousPortfolioValue1H = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage1HInCurrency ?? 0) / 100
                let previousValue = currentValue / (percentChange + 1)
                return previousValue
            }
            .reduce(0, +)
        differencePortfolioValue1H = portfolioValue - previousPortfolioValue1H
        percentagePortfolioChange1H = ((portfolioValue - previousPortfolioValue1H) / previousPortfolioValue1H) * 100
        
        previousPortfolioValue24H = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24HInCurrency ?? 0) / 100
                let previousValue = currentValue / (percentChange + 1)
                return previousValue
            }
            .reduce(0, +)
        differencePortfolioValue24H = portfolioValue - previousPortfolioValue24H
        percentagePortfolioChange24H = ((portfolioValue - previousPortfolioValue24H) / previousPortfolioValue24H) * 100
        
        previousPortfolioValue7D = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage7DInCurrency ?? 0) / 100
                let previousValue = currentValue / (percentChange + 1)
                return previousValue
            }
            .reduce(0, +)
        differencePortfolioValue7D = portfolioValue - previousPortfolioValue7D
        percentagePortfolioChange7D = ((portfolioValue - previousPortfolioValue7D) / previousPortfolioValue7D) * 100
        
        previousPortfolioValue14D = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage14DInCurrency ?? 0) / 100
                let previousValue = currentValue / (percentChange + 1)
                return previousValue
            }
            .reduce(0, +)
        differencePortfolioValue14D = portfolioValue - previousPortfolioValue14D
        percentagePortfolioChange14D = ((portfolioValue - previousPortfolioValue14D) / previousPortfolioValue14D) * 100
        
        previousPortfolioValue30D = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage30DInCurrency ?? 0) / 100
                let previousValue = currentValue / (percentChange + 1)
                return previousValue
            }
            .reduce(0, +)
        differencePortfolioValue30D = portfolioValue - previousPortfolioValue30D
        percentagePortfolioChange30D = ((portfolioValue - previousPortfolioValue30D) / previousPortfolioValue30D) * 100
        
        previousPortfolioValue1Y = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage1YInCurrency ?? 0) / 100
                let previousValue = currentValue / (percentChange + 1)
                return previousValue
            }
            .reduce(0, +)
        differencePortfolioValue1Y = portfolioValue - previousPortfolioValue1Y
        percentagePortfolioChange1Y = ((portfolioValue - previousPortfolioValue1Y) / previousPortfolioValue1Y) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentagePortfolioChange24H)
        
        stats.append(contentsOf: [
            marketCap, volume, btcDominance, portfolio
        ])
        return stats
    }
}
