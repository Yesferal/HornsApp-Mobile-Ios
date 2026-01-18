//
//  SocketManager.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/30/25.
//

import HornsAppCore

class SocketManager: RenderRemoteDataSource {
    var renderStorageDataSource: RenderStorageDataSource

    init(renderStorageDataSource: RenderStorageDataSource) {
        self.renderStorageDataSource = renderStorageDataSource
    }
    
    func getCategoryRender() async throws -> [CategoryRender]? {
        return renderStorageDataSource.getAppRender()?.categories
    }
    
    func getHomeRender() async throws -> [ScreenRender]? {
        return renderStorageDataSource.getAppRender()?.screens
    }
}
