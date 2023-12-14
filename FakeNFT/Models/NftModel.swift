//
//  NftModel.swift
//  FakeNFT
//
//  Created by Aleksey Kolesnikov on 13.12.2023.
//

import Foundation

public struct NftModel {
    let createdAt: Date
    let name: String
    let images: [String]
    let rating: Int
    let description: String?
    let price: Float
    let author: String
    let id: String
}