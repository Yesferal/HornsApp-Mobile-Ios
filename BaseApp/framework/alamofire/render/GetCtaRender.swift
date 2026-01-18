//
//  GetCTADrawe.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/4/26.
//

import HornsAppCore

class GetCtaRender: Decodable {
    var title: GetText?
    var textColor: String?
    var backgroundColor: String?
    var align: String?
    var navigation: GetNavigatorRender?
    
    func mapToCtaRender() -> CtaRender {
        return CtaRender(title: title?.asLocalizedString(), textColor: textColor, backgroundColor: backgroundColor, align: align, navigation: navigation?.mapToNavigatorRender())
    }
}
