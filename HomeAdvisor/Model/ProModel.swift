//
//  Pro.swift
//  HomeAdvisor
//
//  Created by TAEWON KONG on 1/27/20.
//  Copyright © 2020 TAEWON KONG. All rights reserved.
//

import Foundation

struct ProModel: Codable {
    let entityId: String
    let companyName: String
    let ratingCount: Int
    let compositeRating: Double
    let companyOverview: String
    let canadianSP: Bool
    let spanishSpeaking: Bool
    let phoneNumber: String
    let latitude: Double
    let longitude: Double
    let servicesOffered: String
    let specialty: String
    let primaryLocation: String
    let email: String
}
