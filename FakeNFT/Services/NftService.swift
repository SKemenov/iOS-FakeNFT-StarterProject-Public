//
//  NftService.swift
//  FakeNFT
//
//  Created by Iurii on 15.12.23.
//

import Foundation

typealias NftCompletion = (Result<NftResult, Error>) -> Void

protocol NftService {
    func loadNft(id: String, completion: @escaping NftCompletion)
}

final class NftServiceImpl: NftService {
    
    private let networkClient: NetworkClient
    private let storage: NftStorage
    
    init(networkClient: NetworkClient, storage: NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadNft(id: String, completion: @escaping NftCompletion) {
        if let nft = storage.getNft(with: id) {
            completion(.success(nft))
            return
        }
        
        let request = NftRequest(id: id)
        networkClient.send(request: request, type: NftResult.self) { [weak storage] result in
            switch result {
            case .success(let nft):
                storage?.saveNft(nft)
                completion(.success(nft))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
