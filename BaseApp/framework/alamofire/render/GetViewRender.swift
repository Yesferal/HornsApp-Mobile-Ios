//
//  GetViewDrawer.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/4/26.
//

import HornsAppCore

class GetViewRender: Decodable {
    let key: String?
    let data: GetDataRender?
    let style: GetStyleRender?
    let children: GetChildrenRender?
    let navigation: GetNavigatorRender?
    
    func mapToViewRender() -> ViewRender {
        
        return ViewRender(key: key, data: data?.mapToDataRender(), style: style?.mapToStyleRender(), children: children?.mapToChildrenRender(), navigation: navigation?.mapToNavigatorRender())
    }
}
