//
//  HaResult.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/31/25.
//

import HornsAppCore

enum UiResult<T> {
   case success(T)
   case failed(Error)
}

func mapCoreResultAsUiResult<T>(_ result: HaResult<T>) -> UiResult<T> {
    if let success = result as? HaResultSuccess {
        guard let value = success.value else {
            return .failed(HaError.SuccessValueDoNotExist)
        }
        
        return .success(value)
    } else {
        // TODO: Map the error to an accurate and correct error message
        return .failed(HaError.NetworkError)
    }
}

func mapCoreResultAsUiResult<T>(_ result: HaResult<NSArray>) -> UiResult<[T]> {
    if let success = result as? HaResultSuccess<NSArray> {
        guard let value = success.value as? [T] else {
            return .failed(HaError.SuccessValueDoNotExist)
        }
        
        return .success(value)
    } else {
        // TODO: Provide a correct Error Message
        return .failed(HaError.NetworkError)
    }
}
