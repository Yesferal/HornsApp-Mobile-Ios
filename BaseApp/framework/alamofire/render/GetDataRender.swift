//
//  GetDataRender.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/4/26.
//

import HornsAppCore

class GetDataRender: Decodable {
    let title: GetText?
    let subtitle: GetText?
    let description: GetText?
    let icon: String?
    let imageUrl: String?
    let ctas: [GetCtaRender]?
    
    func mapToDataRender() -> DataRender {
        let coreCtas = ctas?.map {
            $0.mapToCtaRender()
        }
        
        return DataRender(title: title?.asLocalizedString(), subtitle: subtitle?.asLocalizedString(), description: description?.asLocalizedString(), icon: icon, imageUrl: imageUrl, ctas: coreCtas)
    }
}
