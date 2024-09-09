import Foundation

public extension Api {
    func getConfirmedSignaturesForAddress2(account: String, configs: RequestConfiguration? = nil, onComplete: @escaping (Result<[SignatureInfo], Error>) -> Void) {
        router.request(parameters: [account, configs]) { (result: Result<[SignatureInfo], Error>) in
            switch result {
            case .success(let signatures):
                onComplete(.success(signatures))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}

public extension ApiTemplates {
    struct GetConfirmedSignaturesForAddress2: ApiTemplate {
        public init(account: String, configs: RequestConfiguration? = nil) {
            self.account = account
            self.configs = configs
        }
        
        public let account: String
        public let configs: RequestConfiguration?
        
        public typealias Success = [SignatureInfo]
        
        public func perform(withConfigurationFrom apiClass: Api, completion: @escaping (Result<Success, Error>) -> Void) {
            apiClass.getConfirmedSignaturesForAddress2(account: account, configs: configs, onComplete: completion)
        }
    }
}
