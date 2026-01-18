//
//  HaFileReaderManager.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import HornsAppCore

class HaFileReaderManager: RenderStorageDataSource {
    
    func getAppRender() -> AppRender? {
        let getAppRender: HaResult<GetAppRender> = loadJSON(HornsAppCoreConfig().appRenderFileName)
        
        switch getAppRender {
        case .success(let getAppRender):
            let appRender = getAppRender.mapToAppRender()
            //print("Yesferal: HaFileReaderManager: GetAppRender: \(appRender)")
            return appRender
        case .failed(let error):
            // TODO: Logger
            print("Yesferal: HaFileReaderManager: GetAppRender: \(error)")
            return nil
        }
    }
    
    func updateAppRender(appRender: AppRender) {
        // TODO: Implement this , but probabbly will be in next versions
    }
    
    private func loadJSON<T: Decodable>(_ filename: String) -> HaResult<T> {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json")
        else {
            return HaResult.failed(HaError.FileNotFoundError)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let dataDecoded = try decoder.decode(T.self, from: data)
            return HaResult.success(dataDecoded)
        } catch {
            return HaResult.failed(error)
        }
    }
}
