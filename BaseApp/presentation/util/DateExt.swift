//
//  DateExt.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/27/26.
//

import HornsAppCore

extension Date {
    func asKotlinTimeInMillis() -> KotlinLong? {        
        return KotlinLong(value: Int64(self.timeIntervalSince1970 * 1000))
    }
    
    func formatDate(to outputFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateFormat = outputFormat
        
        return formatter.string(from: self)
    }
}
