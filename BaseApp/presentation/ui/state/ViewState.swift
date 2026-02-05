//
//  UiState.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/4/26.
//

enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case failed(String, String, String)
}
