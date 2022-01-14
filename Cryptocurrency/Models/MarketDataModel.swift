//
//  MarketDataModel.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import Foundation

// CoinGecko API Info
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 11234,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 680,
     "total_market_cap": {
       "btc": 47421201.08955496,
       "eth": 626028419.5618634,
       "ltc": 13538139561.810932,
       "bch": 4748854252.281757,
       "bnb": 4369860219.801763,
       "eos": 686574482668.9698,
       "xrp": 2781837020777.834,
       "xlm": 8279266559574.604,
       "link": 108445944166.80977,
       "dot": 75332192841.37999,
       "yfi": 91732049.7624251,
       "usd": 2710810295641.8306,
       "aed": 9956670675377.658,
       "ars": 273612113137224.03,
       "aud": 3797002162192.2607,
       "bdt": 232598719012590.16,
       "bhd": 1022151684126.1853,
       "bmd": 2710810295641.8306,
       "brl": 15155056038815.2,
       "cad": 3458096659031.119,
       "chf": 2509716966290.53,
       "clp": 2262144083610153.5,
       "cny": 17312318872087.006,
       "czk": 61560381960374.766,
       "dkk": 17887552816822.2,
       "eur": 2405269445599.4497,
       "gbp": 2037350139844.0535,
       "hkd": 21143642603432.38,
       "huf": 884225726764995.9,
       "idr": 38891588690028980,
       "ils": 8583867547079.333,
       "inr": 203394948254437.47,
       "jpy": 308446703138795.1,
       "krw": 3231526820067381.5,
       "kwd": 820697817005.562,
       "lkr": 549704658357114.56,
       "mmk": 4855146006532479,
       "mxn": 58869588287956,
       "myr": 11491124843225.719,
       "ngn": 1111134032080629,
       "nok": 24529336230277.164,
       "nzd": 3981188167729.643,
       "php": 136508268636015.12,
       "pkr": 478458017180782,
       "pln": 11283994539346.014,
       "rub": 201474198197839.84,
       "sar": 10169585848428.258,
       "sek": 24661108718748.36,
       "sgd": 3712666143084.5474,
       "thb": 91357017773425.42,
       "try": 34496679365788.79,
       "twd": 75288689746008.19,
       "uah": 73768871242946.47,
       "vef": 271433434902.61655,
       "vnd": 61508285608112960,
       "zar": 43755758252116.87,
       "xdr": 1936613718447.7068,
       "xag": 117524171368.12346,
       "xau": 1515803793.014043,
       "bits": 47421201089554.96,
       "sats": 4742120108955496
     },
     "total_volume": {
       "btc": 2355086.4116664142,
       "eth": 31090545.79707572,
       "ltc": 672346709.6721665,
       "bch": 235843079.96358252,
       "bnb": 217021040.97071332,
       "eos": 34097454252.096924,
       "xrp": 138154800312.4596,
       "xlm": 411174489996.4802,
       "link": 5385767623.752636,
       "dot": 3741234292.794943,
       "yfi": 4555702.912328367,
       "usd": 134627389125.27626,
       "aed": 494479668887.68335,
       "ars": 13588440505753.908,
       "aud": 188571103046.4941,
       "bdt": 11551585998065.795,
       "bhd": 50763276480.52222,
       "bmd": 134627389125.27626,
       "brl": 752647881643.7686,
       "cad": 171739986858.0521,
       "chf": 124640460145.1851,
       "clp": 112345209951151.9,
       "cny": 859784357909.6653,
       "czk": 3057282728416.727,
       "dkk": 888352289882.0488,
       "eur": 119453266842.18819,
       "gbp": 101181233707.93831,
       "hkd": 1050059978329.874,
       "huf": 43913438422140.24,
       "idr": 1931478957671969,
       "ils": 426301935741.64014,
       "inr": 10101234634082.834,
       "jpy": 15318436112860.973,
       "krw": 160487814058184.4,
       "kwd": 40758442057.677284,
       "lkr": 27300067091968.27,
       "mmk": 241121863721828.56,
       "mxn": 2923649427932.7544,
       "myr": 570685502502.046,
       "ngn": 55182420528559.445,
       "nok": 1218204202251.7773,
       "nzd": 197718361000.61093,
       "php": 6779431164926.762,
       "pkr": 23761734180611.207,
       "pln": 560398758326.3724,
       "rub": 10005844128263.34,
       "sar": 505053707911.75,
       "sek": 1224748439637.1594,
       "sgd": 184382710343.41763,
       "thb": 4537077640910.939,
       "try": 1713213899170.448,
       "twd": 3739073791870.851,
       "uah": 3663594811530.3843,
       "vef": 13480240473.113914,
       "vnd": 3054695459252510,
       "zar": 2173048959622.8003,
       "xdr": 96178345300.65388,
       "xag": 5836621019.124427,
       "xau": 75279597.17718077,
       "bits": 2355086411666.414,
       "sats": 235508641166641.44
     },
     "market_cap_percentage": {
       "btc": 39.82681611134241,
       "eth": 18.936119989054916,
       "bnb": 3.8477994463312735,
       "usdt": 2.7243719485532334,
       "sol": 2.3290830379078407,
       "ada": 1.8625449039562825,
       "xrp": 1.695473713668387,
       "usdc": 1.4159137912913173,
       "dot": 1.407563626364943,
       "doge": 1.062250610512094
     },
     "market_cap_change_percentage_24h_usd": 5.213143525370775,
     "updated_at": 1638196962
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "gbp" }) {
            return "£" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "gbp" }) {
            return "£" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return "\(item.value.asPercentString())"
        }
        return ""
    }
}
