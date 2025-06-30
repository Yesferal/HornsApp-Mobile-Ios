//
//  AlamoFireWrapper.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/31/25.
//

import Alamofire

class AlamoFireWrapper {
    
    let baseUrl = hapk_wrapper().iosHornsAppApiBaseUrl("Muvin") ?? ""
    let authorization = hapk_wrapper().iosHornsAppApiAuthorization("Muvin") ?? ""
    
    func makeRequest<T: Decodable>(path: String) async throws -> HaResult<T> {
        try await withUnsafeThrowingContinuation { continuation in
            AF.request(baseUrl+path, method: .get, headers: ["authorization": authorization]).validate().responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let events):
                    print(events)
                    continuation.resume(returning: HaResult.success(events))
                    return
                    
                case .failure(let error):
                    print(error)
                    continuation.resume(throwing: error)
                    return
                }
                fatalError("should not get here")
            }
        }
    }
}
