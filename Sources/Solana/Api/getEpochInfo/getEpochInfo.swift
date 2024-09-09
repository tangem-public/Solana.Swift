import Foundation

public extension Api {
    func getEpochInfo(commitment: Commitment? = nil, onComplete: @escaping ((Result<EpochInfo, Error>) -> Void)) {
        router.request(parameters: [RequestConfiguration(commitment: commitment)]) { (result: Result<EpochInfo, Error>) in
            switch result {
            case .success(let epoch):
                onComplete(.success(epoch))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}

public extension ApiTemplates {
    struct GetEpochInfo: ApiTemplate {
        public init(commitment: Commitment? = nil) {
            self.commitment = commitment
        }
        
        public let commitment: Commitment?
        
        public typealias Success = EpochInfo
        
        public func perform(withConfigurationFrom apiClass: Api, completion: @escaping (Result<Success, Error>) -> Void) {
            apiClass.getEpochInfo(commitment: commitment, onComplete: completion)
        }
    }
}
