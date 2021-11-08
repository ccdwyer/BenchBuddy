//
//  Store+Persist.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/23/21.
//

import Foundation

extension Store {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    private static var stateURL: URL {
        return documentsFolder.appendingPathComponent("state.data")
    }
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let stateData = try? Data(contentsOf: Self.stateURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.state = State(nodes: FolderNode.data, exercises: Exercise.data, settings: Settings(unit: .pounds, weightIncrement: 5.0, timeIncrement: 15))
                }
                #endif
                return
            }
            
            
            guard let state = try? JSONDecoder().decode(Store.State.self, from: stateData) else {
                fatalError("Can't decode saved folder data.")
            }
           
            
            DispatchQueue.main.async {
                self?.state = state
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let state = self?.state else { fatalError("Self out of scope") }
            
            guard let stateData = try? JSONEncoder().encode(state) else { fatalError("Error encoding data") }
            
            do {
                let stateOutfile = Self.stateURL
                try stateData.write(to: stateOutfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
