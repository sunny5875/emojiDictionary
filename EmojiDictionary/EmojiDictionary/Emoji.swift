//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by νμλΉ on 2021/04/11.
//

import Foundation
struct Emoji {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    init(symbol: String, name: String, description: String,
        usage: String) {
            self.symbol = symbol
            self.name = name
            self.description = description
            self.usage = usage
        }
    }
