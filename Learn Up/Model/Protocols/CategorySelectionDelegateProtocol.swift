//
//  CategorySelectionProtocol.swift
//  Learn Up
//
//  Created by PowerMac on 18.01.2024.
//

import Foundation

enum CategorySelectionOperation {
    case
    select,
    del
}

protocol CategorySelectionDelegateProtocol {
    var selectCollectionDelegate: ((WordCategoryProtocol?, CategorySelectionOperation) -> Void)? { get set }
}
