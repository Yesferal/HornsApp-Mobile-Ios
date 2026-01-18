//
//  GetAppRender.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import HornsAppCore

class GetAppRender: Decodable {
    var platform: String?
    var appId: String?
    var docVersion: Int64?
    var appVersion: Int64?
    var screens: [GetScreenRender]?
    let categories: [GetCategoryRender]?
    
    func mapToAppRender() -> AppRender {
        let coreScreens = screens?.map {
            $0.mapToScreenRender()
        }

        return AppRender(platform: platform, appId: appId, docVersion: docVersion.toKotlinLong(), appVersion: appVersion.toKotlinLong(), screens: coreScreens, categories: nil)
    }
}
