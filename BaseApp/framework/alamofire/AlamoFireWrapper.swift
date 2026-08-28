//
//  AlamoFireWrapper.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/31/25.
//

import Alamofire
import HornsAppCore

class AlamoFireWrapper: ConcertRemoteDataSource {
    
    let baseUrl: String
    let authorization: String
    let eventPath: String
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 30
        configuration.waitsForConnectivity = false
        return Session(configuration: configuration)
    }()

    init(appSettings: AppSettings) {
        baseUrl = hapk_wrapper().iosHornsAppApiBaseUrl(appSettings.appName) ?? ""
        authorization = hapk_wrapper().iosHornsAppApiAuthorization(appSettings.appName) ?? ""
        eventPath = appSettings.homePath
    }
    
    func getConcert(id: String) async throws -> HaResult<Concert> {
        let path = "\(eventPath)/\(id)"
        let request: UiResult<GetEventDetail> = try await makeRequest(path: path)
        
        switch request {
        case .success(let eventDetail):
            return HaResultSuccess(value: eventDetail.mapToConcert())
        case .failed:
            return HaResultError.shared.asTypedResult()
        }
    }
    
    func getConcerts() async throws -> HaResult<NSArray> {
        let request: UiResult<[GetEvents]> = try await makeRequest(path: eventPath)
        
        switch request {
        case .success(let events):
            return HaResultSuccess(value: events.map { e in
                e.mapToConcert()
            } as NSArray)
        case .failed:
            return HaResultError.shared.asTypedResult()
        }
    }
        
    private func makeRequest<T: Decodable>(path: String) async throws -> UiResult<T> {
        try await withUnsafeThrowingContinuation { continuation in
            session.request(baseUrl+path, method: .get, headers: ["authorization": authorization]).validate().responseDecodable(of: T.self) { response in
                do {
                    let events = try response.result.get()
                    print(events)
                    continuation.resume(returning: UiResult.success(events))
                    return
                } catch {
                    // TODO: Logger error here
                    print("Error: \(error)")
                    continuation.resume(returning: UiResult.failed(HaError.NetworkError))
                    return
                }
            }
            
        }
    }
}
