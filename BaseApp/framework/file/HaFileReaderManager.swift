//
//  HaFileReaderManager.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

struct HaFileReaderManager {
    func loadJSON<T: Decodable>(_ filename: String) -> HaResult<T> {
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
