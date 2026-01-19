//
//  GetAppRender.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import HornsAppCore

class GetAppRender: Decodable {
    let platform: String?
    let appId: String?
    let docVersion: Int64?
    let appVersion: Int64?
    let screens: [GetScreenRender]?
    let categories: [GetCategoryRender]?
    
    func mapToAppRender() -> AppRender {
        let coreScreens = screens?.map {
            $0.mapToScreenRender()
        }

        return AppRender(platform: platform, appId: appId, docVersion: docVersion.toKotlinLong(), appVersion: appVersion.toKotlinLong(), screens: coreScreens, categories: nil)
    }
}
