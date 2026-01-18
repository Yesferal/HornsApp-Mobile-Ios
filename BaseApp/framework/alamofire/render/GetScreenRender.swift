//
//  GetScreenRender.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/3/26.
//

import HornsAppCore

class GetScreenRender: Decodable {
    var key: String?
    var _id: String?
    var title: GetText?
    var views: [GetViewRender]?
    var visibility: Bool?
    
    func mapToScreenRender() -> ScreenRender {
        let coreViews = views?.map {
            $0.mapToViewRender()
        }
        
        return ScreenRender(key: key, _id: _id, title: title?.asLocalizedString(), views: coreViews, visibility: visibility.toKotlinBool())
    }
}
