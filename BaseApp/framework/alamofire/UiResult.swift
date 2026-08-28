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
    if result is HaResultError {
        return .failed(HaError.NetworkError)
    }
    
    if let success = result as? HaResultSuccess<T> {
        guard let value = success.value else {
            return .failed(HaError.SuccessValueDoNotExist)
        }
        
        return .success(value)
    }
    
    return .failed(HaError.NetworkError)
}

func mapCoreResultAsUiResult<T>(_ result: HaResult<NSArray>) -> UiResult<[T]> {
    if result is HaResultError {
        return .failed(HaError.NetworkError)
    }
    
    if let success = result as? HaResultSuccess<NSArray> {
        guard let value = success.value as? [T] else {
            return .failed(HaError.SuccessValueDoNotExist)
        }
        
        return .success(value)
    }
    
    return .failed(HaError.NetworkError)
}

// MARK: - KMP HaResult bridging

extension HaResultError {
    /// Bridges KMP's error singleton to a typed `HaResult<T>`.
    ///
    /// In Kotlin, `HaResult.Error` is `HaResult<Nothing>`, which is a subtype of any `HaResult<T>`.
    /// Swift cannot express that relationship, so this cast is required at the boundary.
    /// It is safe as long as `self` is `HaResultError.shared` (the KMP error branch).
    func asTypedResult<T>() -> HaResult<T> {
        self as! HaResult<T>
    }
}
