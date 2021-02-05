import Foundation

struct Stat: Codable {
    // exclusive for Team Stats
    let ball: Ball?

    let core: Core
    let boost: Boost
    let movement: Movement
    let demo: Demo

    private enum CodingKeys: String, CodingKey {
        case ball
        case core, boost, movement, demo
    }
}

struct Ball: Codable {
    let possessionTime: Double?
    let timeInSide: Double?

    private enum CodingKeys: String, CodingKey {
        case timeInSide     = "time_in_side"
        case possessionTime = "possession_time"
    }
}

struct Core: Codable {
    let shots: Int
    let shotsAgainst: Int
    let shootingPercentage: Double

    let goals: Int
    let goalsAgainst: Int

    let saves: Int
    let assists: Int

    let score: Int
    let mvp: Bool?

    private enum CodingKeys: String, CodingKey {
        case shots, goals, saves, assists, score, mvp
        case shootingPercentage = "shooting_percentage"
        case shotsAgainst       = "shots_against"
        case goalsAgainst       = "goals_against"
    }
}

struct Boost: Codable {
    let bpm: Int
    let amountStolen: Int
    let amountCollected: Int
    let countCollectedBig: Int
    let countCollectedSmall: Int


    private enum CodingKeys: String, CodingKey {
        case bpm
        case amountStolen = "amount_stolen"
        case amountCollected = "amount_collected"
        case countCollectedBig = "count_collected_big"
        case countCollectedSmall = "count_collected_small"
    }
}

struct Movement: Codable {

    let averageSpeed: Int?
    let totalDistance: Int
    let countPowerslide: Int

    private enum CodingKeys: String, CodingKey {
        case averageSpeed               = "avg_speed"
        case totalDistance              = "total_distance"
        case countPowerslide            = "count_powerslide"
    }
}

struct Demo: Codable {
    let inflicted: Int
    let taken: Int

    private enum CodingKeys: String, CodingKey {
        case inflicted, taken
    }
}
