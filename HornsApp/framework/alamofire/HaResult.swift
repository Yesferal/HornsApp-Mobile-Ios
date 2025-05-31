//
//  HaResult.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/31/25.
//

enum HaResult<T> {
   case success(T)
   case failed(String)
}
