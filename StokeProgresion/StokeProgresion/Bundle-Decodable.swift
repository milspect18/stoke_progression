//
//  Bundle-Decodable.swift
//  StokeProgresion
//
//  Created by Kyle Price on 1/19/22.
//

import Foundation

extension Bundle {
    typealias JsonDateDecodeStrategy = JSONDecoder.DateDecodingStrategy
    typealias JsonKeyDecodeStrategy = JSONDecoder.KeyDecodingStrategy
    
    func decode<T: Decodable>(_ type: T.Type,
                             from file: String,
                             dateDecodeStrategy: JsonDateDecodeStrategy = .deferredToDate,
                             keyDecodeStrategy: JsonKeyDecodeStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let fileData = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = dateDecodeStrategy
        decoder.keyDecodingStrategy = keyDecodeStrategy
        
        do {
            return try decoder.decode(T.self, from: fileData)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle " +
                      "due to missing key '\(key.stringValue)' - context \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle " +
                      "due to type mismatch - context \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle " +
                      "due to missing \(type) value - context \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle due to data corruption")
        } catch {
            fatalError("Failed to decode \(file) from bundle. Error: \(error.localizedDescription)")
        }
    }
}
