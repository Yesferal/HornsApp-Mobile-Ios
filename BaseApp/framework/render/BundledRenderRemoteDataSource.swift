//
//  BundledRenderRemoteDataSource.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/30/25.
//

import HornsAppCore

/// Implements `RenderRemoteDataSource` using bundled local render JSON.
/// Replace or compose with a real remote source when live SDUI is added (`#qual-4-remote-render`).
class BundledRenderRemoteDataSource: RenderRemoteDataSource {
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
