//
//  HomeStatsView.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    @Binding var showPortfolioChart: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                if stat.title == "Portfolio Value" {
                    StatisticView(stat: stat)
                        .frame(width: UIScreen.main.bounds.width / 3)
                        .onTapGesture {
                            showPortfolioChart.toggle()
                        }
                } else {
                    StatisticView(stat: stat)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false), showPortfolioChart: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
