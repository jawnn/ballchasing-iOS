import Foundation

protocol MatchHistoryModelType {
    var duels: [Replay] { get }
    var doubles: [Replay] { get }
    var standard: [Replay] { get }

    func loadProfileMatchHistory(completionHandler: @escaping() -> Void)
}

class MatchHistoryModel: MatchHistoryModelType {
    var interactor: ReplayInteractorType = ReplayInteractor()
    var profile = Profile()

    var duels: [Replay] {
        get {
            return profile.duels
        }
    }

    var doubles: [Replay] {
        get {
            return profile.doubles
        }
    }

    var standard: [Replay] {
        get {
            return profile.standard
        }
    }

    func loadProfileMatchHistory(completionHandler: @escaping() -> Void) {
        interactor.fetchDuelsMatchHistory {
            [weak self] duelReplays in
            self?.profile.duels = duelReplays ?? []

            self?.interactor.fetchDoublesMatchHistory {
                [weak self] doubleReplays in
                self?.profile.doubles = doubleReplays ?? []

                self?.interactor.fetchStandardMatchHistory {
                    [weak self] standardReplay in
                    self?.profile.standard = standardReplay ?? []
                    completionHandler()
                }
            }
        }
    }
}
