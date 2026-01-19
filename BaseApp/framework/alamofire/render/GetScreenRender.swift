//
//  GetScreenRender.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/3/26.
//

import HornsAppCore

class GetScreenRender: Decodable {
    let key: String?
    let _id: String?
    let title: GetText?
    let views: [GetViewRender]?
    let visibility: Bool?
    
    func mapToScreenRender() -> ScreenRender {
        let coreViews = views?.map {
            $0.mapToViewRender()
        }
        
        return ScreenRender(key: key, _id: _id, title: title?.asLocalizedString(), views: coreViews, visibility: visibility.toKotlinBool())
    }
}
