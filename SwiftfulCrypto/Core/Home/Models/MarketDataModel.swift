//
//  MarketDataModel.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 09.04.23.
//

import Foundation


/*
 JSON Data
 
 URL: https://api.coingecko.com/api/v3/global

 JSON Response: {
 "data": {
   "active_cryptocurrencies": 10854,
   "upcoming_icos": 0,
   "ongoing_icos": 49,
   "ended_icos": 3376,
   "markets": 710,
   "total_market_cap": {
     "btc": 43666971.6329686,
     "eth": 662905462.2108686,
     "ltc": 13510821993.327425,
     "bch": 9788595030.487125,
     "bnb": 3927502064.397459,
     "eos": 1027403472158.3246,
     "xrp": 2418379319407.0967,
     "xlm": 11765845598886.842,
     "link": 171470721905.0984,
     "dot": 198892591105.7745,
     "yfi": 141704015.4035565,
     "usd": 1221860583694.7336,
     "aed": 4487405179677.29,
     "ars": 255871425468878.44,
     "aud": 1831325864702.247,
     "bdt": 128446752257987.83,
     "bhd": 457788395589.98676,
     "bmd": 1221860583694.7336,
     "brl": 6178680162415.841,
     "cad": 1656781858460.8716,
     "chf": 1106471735752.3518,
     "clp": 994276202117548.9,
     "cny": 8395037512391.38,
     "czk": 26124723326035.45,
     "dkk": 8346040902985.22,
     "eur": 1111338406457.2092,
     "gbp": 983705293605.624,
     "hkd": 9591300116857.725,
     "huf": 420772129206954.94,
     "idr": 18255757887953812,
     "ils": 4386477051742.9307,
     "inr": 99997678656147.72,
     "jpy": 161474926630027.44,
     "krw": 1608506146799093.2,
     "kwd": 374854608471.70703,
     "lkr": 387987849045324.1,
     "mmk": 2548162225144738.5,
     "mxn": 22147200567933.984,
     "myr": 5379852150007.893,
     "ngn": 558628197666466.56,
     "nok": 12823549011934.598,
     "nzd": 1949363706390.0776,
     "php": 66579188092968.37,
     "pkr": 340970202918195.7,
     "pln": 5240294899720.024,
     "rub": 99217278745063.1,
     "sar": 4583344450848.384,
     "sek": 12795690590626.355,
     "sgd": 1624830204197.2551,
     "thb": 41462725792689.016,
     "try": 23518983445248.08,
     "twd": 37154460036908.38,
     "uah": 44609382132017.445,
     "vef": 122344900245.35373,
     "vnd": 28646521384722990,
     "zar": 22084775710713.03,
     "xdr": 900271765508.6146,
     "xag": 48921416105.83802,
     "xau": 608596538.1325107,
     "bits": 43666971632968.59,
     "sats": 4366697163296859.5
   },
   "total_volume": {
     "btc": 1196220.555329371,
     "eth": 18159746.611282226,
     "ltc": 370117788.87849754,
     "bch": 268150461.2154759,
     "bnb": 107590669.21379237,
     "eos": 28144867987.24229,
     "xrp": 66249500349.46024,
     "xlm": 322315604446.30786,
     "link": 4697298541.884264,
     "dot": 5448497958.210085,
     "yfi": 3881864.2479540408,
     "usd": 33471859652.81969,
     "aed": 122928751760.94592,
     "ars": 7009385978033.107,
     "aud": 50167656719.505714,
     "bdt": 3518692493900.7676,
     "bhd": 12540734296.823673,
     "bmd": 33471859652.81969,
     "brl": 169259830455.18518,
     "cad": 45386168096.2408,
     "chf": 30310877642.786297,
     "clp": 27237373835877.69,
     "cny": 229975106116.62753,
     "czk": 715665178422.9026,
     "dkk": 228632884544.54944,
     "eur": 30444196059.783516,
     "gbp": 26947792544.169254,
     "hkd": 262745730309.7211,
     "huf": 11526704308641.506,
     "idr": 500101381479795.9,
     "ils": 120163909209.9035,
     "inr": 2739353662972.872,
     "jpy": 4423472001417.776,
     "krw": 44063694921357.91,
     "kwd": 10268831822.888544,
     "lkr": 10628606081206.594,
     "mmk": 69804795662326.13,
     "mxn": 606704233695.0786,
     "myr": 147376598051.36456,
     "ngn": 15303157234075.344,
     "nok": 351290514242.3079,
     "nzd": 53401205721.26639,
     "php": 1823881766369.5835,
     "pkr": 9340596570649.887,
     "pln": 143553542657.3983,
     "rub": 2717975253156.336,
     "sar": 125556928709.02477,
     "sek": 350527355842.2236,
     "sgd": 44510878966.31959,
     "thb": 1135837064454.2917,
     "try": 644283090527.2998,
     "twd": 1017815688980.7654,
     "uah": 1222037111146.338,
     "vef": 3351537307.0368376,
     "vnd": 784747749560356.8,
     "zar": 604994156385.4164,
     "xdr": 24662200079.636166,
     "xag": 1340161713.8350291,
     "xau": 16671998.574472984,
     "bits": 1196220555329.371,
     "sats": 119622055532937.1
   },
   "market_cap_percentage": {
     "btc": 44.29328684061325,
     "eth": 18.177655982252016,
     "usdt": 6.573054427296995,
     "bnb": 4.0201901357597665,
     "usdc": 2.668846559808699,
     "xrp": 2.1355128872153606,
     "ada": 1.1187438356253656,
     "doge": 0.9343955440757492,
     "steth": 0.8913151892259866,
     "matic": 0.8230539751442507
   },
   "market_cap_change_percentage_24h_usd": -0.5681963895731905,
   "updated_at": 1681044440
 }
}
 
 
 
 */



struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String : Double]
    let marketCapChangePercentage24HUsd: Double
    
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }

    var marketCap: String {
     
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return "sigma"
    }
    
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()        }
        return ""
    }
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return "$" + item.value.formattedWithAbbreviations()        }
        return ""
    }
}
