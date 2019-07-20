//
//  gameRule.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 19/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import Foundation

class GameRule {
    var gameRuleData:Array<Any>!
    init() {}
    
    func getGameRuleJsonData() -> [Any] {
        var result:[Any] = []
        print("djsakljajt")
        do {
            if let file = Bundle.main.url(forResource: "gameData", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [Any] {
                    // json is an array
                    print("2")
                    result = object
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return result
    }
}
