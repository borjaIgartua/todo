//
//  ArrayExtension.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 26/5/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//
//

extension Dictionary {
    
    var lastKey: Key {
        let intIndex = self.count
        let index = self.index(self.startIndex, offsetBy: intIndex)
        return self.keys[index]
    }
}

