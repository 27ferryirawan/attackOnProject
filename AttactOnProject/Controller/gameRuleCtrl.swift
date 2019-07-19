//
//  gameRule.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 19/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import Foundation

class GameRuleCtrl {
    init() {}
    
    func getAllGameRuleData() -> [Any] {
        let gameDataModel = GameRule()
        
        return gameDataModel.getGameRuleJsonData()
    }
}
