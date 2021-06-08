//
//  Constants.swift
//  Milestone Project 13-15
//
//  Created by Andrei Chenchik on 1/6/21.
//

import Foundation

struct K {
    static let countryCell = "countryCell"
    static let detailsItemCell = "detailsItemCell"
    static let detailsController = "detailsVC"
    static let wikiQuery = """
        SELECT ?country ?countryLabel ?article ?population ?life_expectancy ?total_fertility_rate WHERE {
          ?country wdt:P31 wd:Q3624078.
          ?article schema:about ?country;
            schema:isPartOf <https://en.wikipedia.org/>.
          SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }
          OPTIONAL { ?country wdt:P1082 ?population. }
          OPTIONAL { ?country wdt:P2250 ?life_expectancy. }
          OPTIONAL { ?country wdt:P4841 ?total_fertility_rate. }
        }
        """
    static let wikiURL = "https://query.wikidata.org/sparql?query=\(wikiQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&format=json"
}
