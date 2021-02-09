import Foundation

protocol ReplayInteractorType {
    func fetchDuelsMatchHistory(completionHandler: @escaping ([Replay]?) -> Void)
    func fetchDoublesMatchHistory(completionHandler: @escaping ([Replay]?) -> Void)
    func fetchStandardMatchHistory(completionHandler: @escaping ([Replay]?) -> Void)
    func fetchMatchDetails(matchId: String, completionHandler: @escaping (Replay?) -> Void)
}

class ReplayInteractor: ReplayInteractorType {

    var request: AnyObject?

    func fetchDuelsMatchHistory(completionHandler: @escaping ([Replay]?) -> Void) {
        let resource = DuelsMatchHistory()
        let request = APIRequest(resource: resource)
        self.request = request

        request.load(withCompletion: {
            [weak self] (results: ResultWrapper<Replay>?) in
            guard let result = results else {
                print("can't get duels results")
                return
            }
            self?.request = nil
            completionHandler(result.results)
        })
    }

    func fetchDoublesMatchHistory(completionHandler: @escaping ([Replay]?) -> Void) {
        let resource = DoublesMatchHistory()
        let request = APIRequest(resource: resource)
        self.request = request

        request.load(withCompletion: {
            [weak self] (results: ResultWrapper<Replay>?) in
            guard let result = results else {
                print("can't get doubles results")
                return
            }
            self?.request = nil
            completionHandler(result.results)
        })
    }

    func fetchStandardMatchHistory(completionHandler: @escaping ([Replay]?) -> Void) {
        let resource = StandardMatchHistory()
        let request = APIRequest(resource: resource)
        self.request = request

        request.load(withCompletion: {
            [weak self] (results: ResultWrapper<Replay>?) in
            guard let result = results else {
                print("can't get standard results")
                return
            }
            self?.request = nil
            completionHandler(result.results)
        })
    }

    func fetchMatchDetails(matchId: String, completionHandler: @escaping (Replay?) -> Void) {
        var resource = MatchDetailsResource()
        resource.methodPath += matchId
        let request = MatchDetailsRequest(resource: resource)
        self.request = request

        request.load {
            [weak self] replay in
            guard let fetchedReplay = replay else {
                print("fetchReplay nil")
                return
            }
            self?.request = nil
            completionHandler(fetchedReplay)
        }
    }
}
