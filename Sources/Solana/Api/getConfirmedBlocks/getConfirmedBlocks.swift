import Foundation

public extension Api {
    func getConfirmedBlocks(startSlot: UInt64, endSlot: UInt64, onComplete:@escaping (Result<[UInt64], Error>) -> Void) {
        router.request(parameters: [startSlot, endSlot]) { (result: Result<[UInt64], Error>) in
            switch result {
            case .success(let confirmedBlocks):
                onComplete(.success(confirmedBlocks))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}

public extension ApiTemplates {
    struct GetConfirmedBlocks: ApiTemplate {
        public init(startSlot: UInt64, endSlot: UInt64) {
            self.startSlot = startSlot
            self.endSlot = endSlot
        }
        
        public let startSlot: UInt64
        public let endSlot: UInt64
        
        public typealias Success = [UInt64]
        
        public func perform(withConfigurationFrom apiClass: Api, completion: @escaping (Result<Success, Error>) -> Void) {
            apiClass.getConfirmedBlocks(startSlot: startSlot, endSlot: endSlot, onComplete: completion)
        }
    }
}
