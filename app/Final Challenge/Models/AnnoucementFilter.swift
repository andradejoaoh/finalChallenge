//
//  AnnoucementFilter.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 23/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation

struct AnnoucementFilter {
    var name: String?
    var neighborhood: String?
    var categories: [String]?
    
    func matches(annoucement: Annoucement) -> Bool {
        if let name = self.name, !annoucement.annoucementName.contains(name) { return false }
        if let neighborhood = self.neighborhood, neighborhood != annoucement.location { return false}
        if let categories = self.categories, !categories.isEmpty, !categories.contains(annoucement.category) { return false}
        return true
    }
}

extension Sequence where Element == Annoucement {
    func filter(annoucementFilter: AnnoucementFilter) -> [Annoucement] {
        return self.filter(annoucementFilter.matches)
    }
}
