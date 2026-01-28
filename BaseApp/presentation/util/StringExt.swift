//
//  StringExt.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/27/26.
//

extension String? {
    func asFormatDate(from inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let localeIdentifier = "en_US_POSIX"
        guard let input = self else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: localeIdentifier)
        formatter.dateFormat = inputFormat
        
        guard let date = formatter.date(from: input) else {
            return nil
        }
        
        return date
    }
}
