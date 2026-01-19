//
//  GetCTADrawe.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/4/26.
//

import HornsAppCore

class GetCtaRender: Decodable {
    let title: GetText?
    let textColor: String?
    let backgroundColor: String?
    let align: String?
    let navigation: GetNavigatorRender?
    
    func mapToCtaRender() -> CtaRender {
        return CtaRender(title: title?.asLocalizedString(), textColor: textColor, backgroundColor: backgroundColor, align: align, navigation: navigation?.mapToNavigatorRender())
    }
}
