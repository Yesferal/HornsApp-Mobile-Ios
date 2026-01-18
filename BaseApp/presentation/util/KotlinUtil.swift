//
//  KotlinUtil.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/22/25.
//

import HornsAppCore

extension Int64? {
    func toKotlinLong() -> KotlinLong? {
        let kotlinValue: KotlinLong?
        if let validValue = self {
            kotlinValue = KotlinLong(value: validValue)
        } else {
            kotlinValue = nil
        }
        
        return kotlinValue
    }
}

extension Bool? {
    func toKotlinBool() -> KotlinBoolean? {
        let kotlinValue: KotlinBoolean?
        if let validValue = self {
            kotlinValue = KotlinBoolean(value: validValue)
        } else {
            kotlinValue = nil
        }
        
        return kotlinValue
    }
}

extension Int? {
    func toKotlinInt() -> KotlinInt? {
        let kotlinValue: KotlinInt?
        if let validValue = self {
            kotlinValue = KotlinInt(value: Int32(validValue))
        } else {
            kotlinValue = nil
        }
        
        return kotlinValue
    }
}
