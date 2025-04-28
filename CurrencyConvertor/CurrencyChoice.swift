//
//  CurrencyChoice.swift
//  CurrencyConvertor
//
//

import Foundation
import SwiftUI

enum CurrencyChoice: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case Usa = "USD",
         Euro = "EUR",
         BritishPound = "GBP",
         Afghani = "AFN",
         Algerian = "DZD",
         Angolia = "AOA",
         Argentina = "ARS",
         Armenia = "AMD",
         Aruba = "AWG",
         Australian = "AUD",
         Azerbaijani = "AZN",
         Bahamian = "BSD",
         Bahrain = "BHD",
         Bangladesh = "BDT",
         Barbadian = "BBD",
         Belarussian = "BYN",
         Belize = "BZD",
         Bermudan = "BMD",
         Bhutanese = "BTN",
         Bolivian = "BOB",
         BrazilReal = "BRL",
         Brunei = "BND",
         Bulgarian = "BGN",
         Burundia = "BIF",
         CAfrica = "XAF",
         Cambodian = "KHR",
         Canada = "CAD",
         Cape = "CVE",
         Cayman = "KYD",
         Chezh = "CZK",
         ChilleanPeso = "CLP",
         Chinese = "CNY",
         ColombiaPeso = "COP",
         Comorian = "KMF",
         Congolia = "CDF",
         CostaRica = "CRC",
         Croatian = "HRK",
         Cuban = "CUP",
         Danish = "DKK",
         Djiboutian = "DJF",
         Dobra = "STN",
         Dominican = "DOP",
         ECarribiean = "XCD",
         Egyptian = "EGP",
         Eritrean = "ERN",
         Ethiopian = "ETB",
         Fijian = "FJD",
         Gambian = "GMD",
         Georgia = "GEL",
         GhanianCedi = "GHS",
         Gibraltar = "GIP",
         Guatemala = "GTQ",
         Guinean = "GNF",
         Guyanaese = "GYD",
         HK = "HKD",
         Haitian = "HTG",
         Honduran = "HNL",
         Hungarian = "HUF",
         Iceland = "ISK",
         Indian = "INR",
         Indonesia = "IDR",
         Iranian = "IRR",
         Iraqi = "IQD",
         Israel = "ILS",
         Jamaican = "JMD",
         Jordanian = "JOD",
         Japan = "JPY",
         Kazakhstan = "KZT",
         Kenyan = "KES",
         Kuwait = "KWD",
         Kyrgyzstani = "KGS",
         Laotian = "LAK",
         Lebanesse = "LBP",
         Liberian = "LRD",
         Libyan = "LYD",
         Macedonia = "MKD",
         Malagasy = "MGA",
         Malawiyan = "MWK",
         Malaysia = "MYR",
         Maldive = "MVR",
         Mauritania = "MUR",
         MauritanianOuguiya = "MRU",
         MexicanPeso = "MXN",
         Moldova = "MDL",
         Mongolian = "MNT",
         Moroccan = "MAD",
         Mozambia = "MZN",
         Myanma = "MMK",
         NZealand = "NZD",
         Nambian = "NAD",
         Nepale = "NPR",
         Netherlands = "ANG",
         Nicaraguan = "NIO",
         Nigerian = "NGN",
         Norwegian = "NOK",
         Omani = "OMR",
         Pakistani = "PKR",
         Panama = "PAB",
         PapuaNewGwenai = "PGK",
         Paraguyan = "PYG",
         Peruvian = "PEN",
         Phillipense = "PHP",
         Polish = "PLN",
         Qatari = "QAR",
         Romania = "RON",
         Rubles = "RUB",
         Rwanda = "RWF",
         SAfrica = "ZAR",
         SKorea = "KRW",
         SSudanese = "SSP",
         Samoan = "WST",
         Saudia = "SAR",
         Serbian = "RSD",
         Seychell = "SCR",
         Sierra = "SLL",
         Singapore = "SGD",
         SolomonIsland = "SBD",
         Somali = "SOS",
         SriLanka = "LKR",
         Sudanese = "SDG",
         Surinamese = "SRD",
         Swazi = "SZL",
         Swiss = "CHF",
         Swedish = "SEK",
         SyrianPound = "SYP",
         Taiwan = "TWD",
         Tajikistani = "TJS",
         Tanzanian = "TZS",
         Thai = "THB",
         Tongan = "TOP",
         Tunisian = "TND",
         Turkish = "TRY",
         Turkmenistani = "TMT",
         UAEDirhams = "AED",
         Ugandan = "UGX",
         Ukranian = "UAH",
         Uruguayan = "UYU",
         Uzbekistan = "UZS",
         Vanuatau = "VUV",
         Venezuela = "VES",
         Vietnam = "VND",
         WAfrica = "XOF",
         Yemeni = "YER",
         Zambian = "ZMW"
    
    func image() -> Image {
        switch self {
        case .Usa:                  return Image("usa")
        case .Euro:                 return Image("euro")
        case .MexicanPeso:          return Image("peso")
        case .BritishPound:         return Image("pound")
        case .Nigerian:             return Image("nigerian")
        case .Canada:               return Image("Canada")
        case .Chinese:              return Image("China")
        case .Kazakhstan:           return Image("kz")
        case .Rubles:               return Image("rub")
        case .Indian:               return Image("India")
        case .Australian:           return Image("Australia")
        case .Turkish:              return Image("turkish")
        case .UAEDirhams:           return Image("aed")
        case .SAfrica:              return Image("Safrica")
        case .ColombiaPeso:         return Image("Colombia")
        case .GhanianCedi:          return Image("ghana")
        case .BrazilReal:           return Image("Brazil")
        case .SKorea:               return Image("SouthKorea")
        case .Phillipense:          return Image("Philippines")
        case .Kuwait:               return Image("Kuwait")
        case .Swiss:                return Image("Switzerland")
        case .Swedish:              return Image("Swedish")
        case .NZealand:             return Image("NZealand")
        case .Singapore:            return Image("Singapore")
        case .HK:                   return Image("HK")
        case .Norwegian:            return Image("Norwegian")
        case .Danish:               return Image("Danish")
        case .Polish:               return Image("Polish")
        case .Taiwan:               return Image("Taiwan")
        case .Thai:                 return Image("Thai")
        case .Malaysia:             return Image("Malaysia")
        case .Israel:               return Image("Israel")
        case .Hungarian:            return Image("Hungarian")
        case .Saudia:               return Image("Saudia")
        case .Chezh:                return Image("Chezh")
        case .Indonesia:            return Image("Indonesia")
        case .ChilleanPeso:         return Image("Chille")
        case .Romania:              return Image("Romania")
        case .Peruvian:             return Image("Peruvian")
        case .Pakistani:            return Image("Pakistani")
        case .Iraqi:                return Image("Iraqi")
        case .Jordanian:            return Image("Jordanian")
        case .Kenyan:               return Image("Kenyan")
        case .Argentina:            return Image("Argentina")
        case .Egyptian:             return Image("Egyptian")
        case .Vietnam:              return Image("Vietnam")
        case .Qatari:               return Image("Qatari")
        case .Omani:                return Image("Omani")
        case .Bulgarian:            return Image("Bulgarian")
        case .Tunisian:             return Image("Tunisian")
        case .Moroccan:             return Image("Moroccan")
        case .Bahrain:              return Image("Bahrain")
        case .Iceland:              return Image("Iceland")
        case .SriLanka:             return Image("SriLanka")
        case .Croatian:             return Image("Croatian")
        case .Georgia:              return Image("Georgia")
        case .Ukranian:             return Image("Ukranian")
        case .Iranian:              return Image("Iranian")
        case .CAfrica:              return Image("CAfrica")
        case .Bangladesh:           return Image("Bangladesh")
        case .Mauritania:           return Image("Mauritania")
        case .Fijian:               return Image("Fijian")
        case .WAfrica:              return Image("WAfrica")
        case .Bolivian:             return Image("Bolivian")
        case .Uruguayan:            return Image("Uruguayan")
        case .Uzbekistan:           return Image("Uzbekistan")
        case .Macedonia:            return Image("Macedonia")
        case .Armenia:              return Image("Armenia")
        case .Moldova:              return Image("Moldova")
        case .Kyrgyzstani:          return Image("Kyrgyzstani")
        case .Turkmenistani:        return Image("Turkmenistani")
        case .Tajikistani:          return Image("Tajikistani")
        case .Venezuela:            return Image("Venezuela")
        case .Dominican:            return Image("Dominican")
        case .Algerian:             return Image("Algerian")
        case .Jamaican:             return Image("Jamaican")
        case .Ugandan:              return Image("Ugandan")
        case .CostaRica:            return Image("CostaRica")
        case .Brunei:               return Image("Brunei")
        case .Libyan:               return Image("Libyan")
        case .ECarribiean:          return Image("ECarribiean")
        case .Barbadian:            return Image("Barbadian")
        case .Lebanesse:            return Image("Lebanesse")
        case .SyrianPound:          return Image("Syrian")
        case .Nepale:               return Image("Nepale")
        case .Cambodian:            return Image("Cambodian")
        case .Guatemala:            return Image("Guatemala")
        case .Paraguyan:            return Image("Paraguyan")
        case .Tanzanian:            return Image("Tanzanian")
        case .Bahamian:             return Image("Bahamian")
        case .Netherlands:          return Image("Netherlands")
        case .Honduran:             return Image("Honduran")
        case .Nambian:              return Image("Nambian")
        case .Ethiopian:            return Image("Ethiopian")
        case .Cuban:                return Image("Cuban")
        case .Bermudan:             return Image("Bermudan")
        case .Nicaraguan:           return Image("Nicaraguan")
        case .Malawiyan:            return Image("Malawiyan")
        case .Panama:               return Image("Panama")
        case .Guyanaese:            return Image("Guyanaese")
        case .Vanuatau:             return Image("vanuatu")
        case .Haitian:              return Image("Haitian")
        case .PapuaNewGwenai:       return Image("NewGwenai")
        case .Samoan:               return Image("Samoan")
        case .Yemeni:               return Image("Yemeni")
        case .Laotian:              return Image("Laotian")
        case .Gambian:              return Image("Gambian")
        case .Belize:               return Image("Belize")
        case .Cayman:               return Image("Cayman")
        case .Sudanese:             return Image("Sudanese")
        case .SSudanese:            return Image("SSudanese")
        case .Mongolian:            return Image("Mongolian")
        case .Malagasy:             return Image("Malagasy")
        case .Cape:                 return Image("Cape")
        case .Angolia:              return Image("Angolia")
        case .Seychell:             return Image("Seychell")
        case .Aruba:                return Image("Aruba")
        case .Sierra:               return Image("Sierra")
        case .Guinean:              return Image("Guinean")
        case .Myanma:               return Image("Myanma")
        case .Rwanda:               return Image("Rwanda")
        case .Maldive:              return Image("Maldive")
        case .SolomonIsland:        return Image("SolomonIsland")
        case .Tongan:               return Image("Tongan")
        case .Somali:               return Image("Somali")
        case .Djiboutian:           return Image("Djiboutian")
        case .Burundia:             return Image("Burundia")
        case .Bhutanese:            return Image("Bhutanese")
        case .Liberian:             return Image("Liberian")
        case .Surinamese:           return Image("Surinamese")
        case .Swazi:                return Image("Swazi")
        case .Eritrean:             return Image("Eritrean")
        case .Comorian:             return Image("Comorian")
        case .Mozambia:             return Image("Mozambia")
        case .Azerbaijani:          return Image("Azerbaijani")
        case .Afghani:              return Image("Afghani")
        case .Congolia:             return Image("Congolia")
        case .Belarussian:          return Image("Belarussian")
        case .Serbian:              return Image("Serbian")
        case .Zambian:              return Image("Zambian")
        case .MauritanianOuguiya:   return Image("Mauritania")
        case .Dobra:                return Image("Dobra")
        case .Gibraltar:            return Image("Gibraltar")
        case .Japan:                return Image("Japan")
        }
    }
    
    func fetchMenuName() -> String {
        switch self {
            
        case .Usa:                  return "🇺🇸 US Dollar"
        case .Euro:                 return "🇪🇺 Euro"
        case .BritishPound:         return "🇬🇧 British Pound"
        case .Afghani:              return "🇦🇫 Afghan Afghani"
        case .Algerian:             return "🇩🇿 Algerian Dinar"
        case .Angolia:              return "🇦🇴 Angolan Kwanza"
        case .Argentina:            return "🇦🇷 Argentine Peso"
        case .Armenia:              return "🇦🇲 Armenian Dram"
        case .Aruba:                return "🇦🇼 Aruban Florin"
        case .Australian:           return "🇦🇺 Australian Dollar"
        case .Azerbaijani:          return "🇦🇿 Azerbaijan Manat"
        case .Bahamian:             return "🇧🇸 Bahamian Dollar"
        case .Bahrain:              return "🇧🇭 Bahrain Dinar"
        case .Bangladesh:           return "🇧🇩 Bangladesh Taka"
        case .Barbadian:            return "🇧🇧 Barbadian Dollar"
        case .Belarussian:          return "🇧🇾 Belarusian Ruble"
        case .Belize:               return "🇧🇿 Belize Dollar"
        case .Bermudan:             return "🇧🇲 Bermudan Dollar"
        case .Bhutanese:            return "🇧🇹 Bhutanese Ngultrum"
        case .Bolivian:             return "🇧🇴 Bolivian Boliviano"
        case .BrazilReal:           return "🇧🇷 Brazilian Real"
        case .Brunei:               return "🇧🇳 Brunei Dollar"
        case .Bulgarian:            return "🇧🇬 Bulgarian Lev"
        case .Burundia:             return "🇧🇮 Burundian Franc"
        case .CAfrica:              return "🇨🇫 Central African Franc"
        case .Cambodian:            return "🇰🇭 Cambodian Riel"
        case .Canada:               return "🇨🇦 Canadian Dollar"
        case .Cape:                 return "🇨🇻 Cape Verdean Escudo"
        case .Cayman:               return "🇰🇾 Cayman Island Dollar"
        case .Chezh:                return "🇨🇿 Czech Koruna"
        case .ChilleanPeso:         return "🇨🇱 Chilean Peso"
        case .Chinese:              return "🇨🇳 Chinese Yuan"
        case .ColombiaPeso:         return "🇨🇴 Colombian Peso"
        case .Comorian:             return "🇰🇲 Comorian Franc"
        case .Congolia:             return "🇨🇩 Congolese Franc"
        case .CostaRica:            return "🇨🇷 Costa Rican Colon"
        case .Croatian:             return "🇭🇷 Croatian Kuna"
        case .Cuban:                return "🇨🇺 Cuban Peso"
        case .Danish:               return "🇩🇰 Danish Krone"
        case .Djiboutian:           return "🇩🇯 Djiboutian Franc"
        case .Dobra:                return "🇸🇹 Dobra"
        case .Dominican:            return "🇩🇴 Dominican Peso"
        case .ECarribiean:          return "🇦🇬 East Caribbean Dollar"
        case .Egyptian:             return "🇪🇬 Egyptian Pound"
        case .Eritrean:             return "🇪🇷 Eritrean Nakfa"
        case .Ethiopian:            return "🇪🇹 Ethiopian Birr"
        case .Fijian:               return "🇫🇯 Fijian Dollar"
        case .Gambian:              return "🇬🇲 Gambian Dalasi"
        case .Georgia:              return "🇬🇪 Georgian Lari"
        case .GhanianCedi:          return "🇬🇭 Ghanaian Cedi"
        case .Gibraltar:            return "🇬🇮 Girbaltar Pound"
        case .Guatemala:            return "🇬🇹 Guatemalan Quetzal"
        case .Guinean:              return "🇬🇳 Guinean Franc"
        case .Guyanaese:            return "🇬🇾 Guyanaese Dollar"
        case .HK:                   return "🇭🇰 Hong Kong Dollar"
        case .Haitian:              return "🇭🇹 Haitian Gourde"
        case .Honduran:             return "🇭🇳 Honduran Lempira"
        case .Hungarian:            return "🇭🇺 Hungarian Forint"
        case .Iceland:              return "🇮🇸 Iceland Króna"
        case .Indian:               return "🇮🇳 Indian Rupee"
        case .Indonesia:            return "🇮🇩 Indonesian Rupiah"
        case .Iranian:              return "🇮🇷 Iranian Rial"
        case .Iraqi:                return "🇮🇶 Iraq Dinar"
        case .Israel:               return "🇮🇱 Israel Shekel"
        case .Jamaican:             return "🇯🇲 Jamaican Dollar"
        case .Jordanian:            return "🇯🇴 Jordanian Dinar"
        case .Japan:                return "🇯🇵 Japanese Yen"
        case .Kazakhstan:           return "🇰🇿 Kazakhstan Tenge"
        case .Kenyan:               return "🇰🇪 Kenyan Shilling"
        case .Kuwait:               return "🇰🇼 Kuwait Dinar"
        case .Kyrgyzstani:          return "🇰🇬 Kyrgystan Som"
        case .Laotian:              return "🇱🇦 Laotian Kip"
        case .Lebanesse:            return "🇱🇧 Lebanese Pound"
        case .Liberian:             return "🇱🇷 Liberian Dollar"
        case .Libyan:               return "🇱🇾 Libyan Dinar"
        case .Macedonia:            return "🇲🇰 Macedonian Denar"
        case .Malagasy:             return "🇲🇬 Malagasy Ariary"
        case .Malawiyan:            return "🇲🇼 Malawian Kwacha"
        case .Malaysia:             return "🇲🇾 Malaysian Ringgit"
        case .Maldive:              return "🇲🇻 Maldivian Rufiyaa"
        case .Mauritania:           return "🇲🇺 Mauritian Rupee"
        case .MauritanianOuguiya:   return "🇲🇷 Mauritanian Ouguiya"
        case .MexicanPeso:          return "🇲🇽 Mexican Peso"
        case .Moldova:              return "🇲🇩 Moldovan Leu"
        case .Mongolian:            return "🇲🇳 Mangolian Tugrik"
        case .Moroccan:             return "🇲🇦 Moroccan Dirham"
        case .Mozambia:             return "🇲🇿 Mozambican Metical"
        case .Myanma:               return "🇲🇲 Myanmar Kyat"
        case .NZealand:             return "🇳🇿 New Zealand Dollar"
        case .Nambian:              return "🇳🇦 Nambian Dollar"
        case .Nepale:               return "🇳🇵 Nepalese Rupee"
        case .Netherlands:          return "🇳🇱 Netherlands Guilder"
        case .Nicaraguan:           return "🇳🇮 Nicaraguan Cordoba"
        case .Nigerian:             return "🇳🇬 Nigerian Naira"
        case .Norwegian:            return "🇳🇴 Norwegian Krone"
        case .Omani:                return "🇴🇲 Oman Rial"
        case .Pakistani:            return "🇵🇰 Pakistan Rupee"
        case .Panama:               return "🇵🇦 Panamanian Balboa"
        case .PapuaNewGwenai:       return "🇵🇬 Papua New Guinean Kina"
        case .Paraguyan:            return "🇵🇾 Paraguayan Guarani"
        case .Peruvian:             return "🇵🇪 Peruvian Sol"
        case .Phillipense:          return "🇵🇭 Philippine Peso"
        case .Polish:               return "🇵🇱 Polish Zloty"
        case .Qatari:               return "🇶🇦 Qatar Riyal"
        case .Romania:              return "🇷🇴 Romanian Leu"
        case .Rubles:               return "🇷🇺 Russian Rubles"
        case .Rwanda:               return "🇷🇼 Rwandan Franc"
        case .SAfrica:              return "🇿🇦 South African Rand"
        case .SKorea:               return "🇰🇷 South Korea Won"
        case .SSudanese:            return "🇸🇸 South Sudanese Pound"
        case .Samoan:               return "🇼🇸 Samoan Tala"
        case .Saudia:               return "🇸🇦 Saudi Riyal"
        case .Serbian:              return "🇷🇸 Serbian Dinar"
        case .Seychell:             return "🇸🇨 Seychellois Rupee"
        case .Sierra:               return "🇸🇱 Sierra Leone"
        case .Singapore:            return "🇸🇬 Singapore Dollar"
        case .SolomonIsland:        return "🇸🇧 Solomon Dollar"
        case .Somali:               return "🇸🇴 Somali Shilling"
        case .SriLanka:             return "🇱🇰 Sri Lankan Rupee"
        case .Sudanese:             return "🇸🇩 Sudanese Pound"
        case .Surinamese:           return "🇸🇷 Surinamese Dollar"
        case .Swazi:                return "🇸🇿 Swazi Lilangeni"
        case .Swiss:                return "🇨🇭 Swiss Franc"
        case .Swedish:              return "🇸🇪 Swedish Krona"
        case .SyrianPound:          return "🇸🇾 Syrian Pound"
        case .Taiwan:               return "🇹🇼 Taiwan Dollar"
        case .Tajikistani:          return "🇹🇯 Tajikistan Somoni"
        case .Tanzanian:            return "🇹🇿 Tanzanian Shilling"
        case .Thai:                 return "🇹🇭 Thai Baht"
        case .Tongan:               return "🇹🇴 Tongan Pa'anga"
        case .Tunisian:             return "🇹🇳 Tunisian Dinar"
        case .Turkish:              return "🇹🇷 Turkish Lira"
        case .Turkmenistani:        return "🇹🇲 Turkmeny Manat"
        case .UAEDirhams:           return "🇦🇪 UAE Dirham"
        case .Ugandan:              return "🇺🇬 Ugandan Shilling"
        case .Ukranian:             return "🇺🇦 Ukrainian Hryvna"
        case .Uruguayan:            return "🇺🇾 Uruguayan Peso"
        case .Uzbekistan:           return "🇺🇿 Uzbekistan Som"
        case .Vanuatau:             return "🇻🇺 Vanuatu Vatu"
        case .Venezuela:            return "🇻🇪 Venezuelan Bolivar"
        case .Vietnam:              return "🇻🇳 Vietnam Dong"
        case .WAfrica:              return "🇿🇦 West African Franc"
        case .Yemeni:               return "🇾🇪 Yemen Rial"
        case .Zambian:              return "🇿🇲 Zambian Kwacha"
    
        }
    }
    
}
