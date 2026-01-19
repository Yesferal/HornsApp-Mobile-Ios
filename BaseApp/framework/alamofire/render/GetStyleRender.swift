//
//  GetStyleRender.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/16/26.
//

import HornsAppCore

class GetStyleRender: Decodable {
    let width: Int?
    let height: Int?
    let textColor: String?
    let backgroundColor: String?
    let elevation: Bool?
    let visibility: Bool?
    
    func mapToStyleRender() -> StyleRender {
        return StyleRender(width: width.toKotlinInt(), height: height.toKotlinInt(), textColor: textColor, backgroundColor: backgroundColor, elevation: elevation.toKotlinBool(), visibility: visibility.toKotlinBool())
    }
}
