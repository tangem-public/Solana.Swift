import Foundation

public extension Api {
    func getLeaderSchedule(epoch: UInt64? = nil, commitment: Commitment? = nil, onComplete: @escaping(Result<[String: [Int]]?, Error>) -> Void) {
        router.request(parameters: [epoch, RequestConfiguration(commitment: commitment)]) { (result: Result<[String: [Int]]?, Error>) in
            switch result {
            case .success(let array):
                onComplete(.success(array))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}

public extension ApiTemplates {
    struct GetLeaderSchedule: ApiTemplate {
        public init(epoch: UInt64? = nil, commitment: Commitment? = nil) {
            self.epoch = epoch
            self.commitment = commitment
        }
        
        public let epoch: UInt64?
        public let commitment: Commitment?
        
        public typealias Success = [String: [Int]]?
        
        public func perform(withConfigurationFrom apiClass: Api, completion: @escaping (Result<Success, Error>) -> Void) {
            apiClass.getLeaderSchedule(epoch: epoch, commitment: commitment, onComplete: completion)
        }
    }
}
