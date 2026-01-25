//
//  GetNavigationRender.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/4/26.
//

import HornsAppCore

class GetNavigatorRender: Decodable {
    let key: String?
    let parameters: [String: StringOrObject]?
    
    func mapToNavigatorRender() -> NavigatorRender {
        let kotlinDict = KotlinMutableDictionary<NSString, AnyObject>()

        parameters?.forEach { key, value in
            kotlinDict[key as NSString] = value as AnyObject
        }
        
        return NavigatorRender(key: key, parameters: kotlinDict)
    }
}

enum StringOrObject: Decodable {
    case string(String)
    case object([String:String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let string = try? container.decode(String.self) {
            self = .string(string)
        } else {
            self = .object(try container.decode([String:String].self))
        }
    }
    
    func getStringValue(key: String? = nil) -> String? {
            if case .string(let value) = self {
                return value
            }
            return nil
        }
}
