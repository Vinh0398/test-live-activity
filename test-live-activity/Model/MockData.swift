//
//  MockData.swift
//  test-live-activity
//
//  Created by DucVinh on 14.08.2023.
//
import ActivityKit
import Foundation

struct MockData: ActivityAttributes {
    public struct ContentState : Codable, Hashable {
        var status : ValueStatus = .assigning
        var value : Double
    }
}

enum ValueStatus: String, CaseIterable, Codable, Equatable {
    case assigning = "Assigning"
    case accepted = "Accepted"
    case inprocess = "Inprocess"
    case completed = "Completed"
}
