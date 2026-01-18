//
//  Untitled.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/17/26.
//

import HornsAppCore

class GetCategoryRender: Decodable {
    let _id: String?
    let name: GetText?
    
    func mapToCategoryRender() -> CategoryRender {
        return CategoryRender(_id: _id, name: name?.asLocalizedString())
    }
}
