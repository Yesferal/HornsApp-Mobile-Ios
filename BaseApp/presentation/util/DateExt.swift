//
//  DateExt.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/27/26.
//

import HornsAppCore

extension Date? {
    func asKotlinTimeInMillis() -> KotlinLong? {
        guard let self else { return nil }
        
        return KotlinLong(value: Int64(self.timeIntervalSince1970 * 1000))
    }
}
