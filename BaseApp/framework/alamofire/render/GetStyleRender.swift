//
//  GetStyleRender.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/16/26.
//

import HornsAppCore

class GetStyleRender: Decodable {
    var width: Int?
    var height: Int?
    var textColor: String?
    var backgroundColor: String?
    var elevation: Bool?
    var visibility: Bool?
    
    func mapToStyleRender() -> StyleRender {
        return StyleRender(width: width.toKotlinInt(), height: height.toKotlinInt(), textColor: textColor, backgroundColor: backgroundColor, elevation: elevation.toKotlinBool(), visibility: visibility.toKotlinBool())
    }
}
