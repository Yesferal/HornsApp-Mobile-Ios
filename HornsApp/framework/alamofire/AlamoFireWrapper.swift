//
//  AlamoFireWrapper.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/31/25.
//

import Alamofire

class AlamoFireWrapper {
    
    let baseUrl: String
    let authorization: String

    init(appName: String) {
        baseUrl = hapk_wrapper().iosHornsAppApiBaseUrl(appName) ?? ""
        authorization = hapk_wrapper().iosHornsAppApiAuthorization(appName) ?? ""
    }
        
    func makeRequest<T: Decodable>(path: String) async throws -> HaResult<T> {
        try await withUnsafeThrowingContinuation { continuation in
            AF.request(baseUrl+path, method: .get, headers: ["authorization": authorization]).validate().responseDecodable(of: T.self) { response in
                do {
                    let events = try response.result.get()
                    print(events)
                    continuation.resume(returning: HaResult.success(events))
                    return
                } catch {
                    // TODO: Logger error here
                    print("Error: \(error)")
                    continuation.resume(returning: HaResult.failed(HaError.NetworkError))
                    return
                }
            }
            
        }
    }
}
