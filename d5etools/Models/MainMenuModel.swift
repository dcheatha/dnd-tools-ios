//
//  MainMenuModel.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

struct MainMenuCategory: Identifiable {
    let name: String
    let items: [MainMenuModel]
    
    var id: String { name }
    
    static func build() -> [MainMenuCategory] {
        return [
//            MainMenuCategory(
//                  name: "Players",
//                  items: [
//                      MainMenuModel(id: "race", name: "Races"),
//                      MainMenuModel(id: "class", name: "Classes"),
//                      MainMenuModel(id: "feat", name: "Feats"),
//                      MainMenuModel(id: "feature", name: "Options & Features"),
//                      MainMenuModel(id: "background", name: "Backgrounds"),
//                      MainMenuModel(id: "item", name: "Items"),
//                      MainMenuModel(id: "spell", name: "Spells"),
//                  ]
//              ),
              MainMenuCategory(
                  name: "Rules",
                  items: [
                      MainMenuModel(id: "adventure", name: "Adventures"),
                      MainMenuModel(id: "book", name: "Books"),
//                      MainMenuModel(id: "qr", name: "Quick Reference"),
//                      MainMenuModel(id: "condition", name: "Conditions"),
                  ]
              ),
              MainMenuCategory(
                  name: "Dungeon Masters",
                  items: [
                      MainMenuModel(id: "bestiary", name: "Bestiary"),
//                      MainMenuModel(id: "lootgen", name: "Loot Generator"),
//                      MainMenuModel(id: "crcalc", name: "Challenge Rating Calculator"),
                  ]
              )
          ]
    }
}

struct MainMenuModel: Identifiable {
    let id: String
    let name: String
    
    var tag: String {
        "{@\(id)}"
    }
}
