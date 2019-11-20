//
//  CoreData.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 19/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import CoreData

class CoreDataStore {

    static let shared = CoreDataStore()

    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "NetworkUsage")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            } else {
//                do {
//                    let record = Models.UsageRecord(volumeOfData: 10.0, date: try Models.Date(string: "1990-Q1"), id: "dfsfg")
//                    self?.save(records: [record])
//                    self?.printAll()
//                } catch {
//                    print(error)
//                }

            }
        }
    }
    
    private func printRecords() {
        let context = container.viewContext
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "UsageRecord")
        do {
            let result = try context.fetch(req)
            try result.forEach { (res) in
                if let mo = res as? NSManagedObject {
                    let usageRecord = try Models.UsageRecord(managedObject: mo)
                    print(usageRecord)
                } else {
                    throw Errors.generic("fetch result not NSManagedObject")
                }

            }
        } catch {
            print(error)
        }


    }

    func save(records: [Models.UsageRecord]) throws {
        let context = container.viewContext
        if let entityDescription = NSEntityDescription.entity(forEntityName: "UsageRecord", in: context) {
            records.forEach { (record) in
                let managedObject = NSManagedObject(entity: entityDescription, insertInto: context)
                managedObject.setValue(record.id, forKey: "id")
                managedObject.setValue(record.volumeOfData, forKey: "dataVolume")
                managedObject.setValue(record.date?.year, forKey: "year")
                managedObject.setValue(record.date?.quarter, forKey: "quarter")
                managedObject.setValue(record.isDecreaseOverQuarter, forKey: "isDecreaseOverQuarter")
            }
        }
        do {
            try context.save()
        } catch {
            print(error)
            throw error
        }
    }

    func retrieveAllRecords() throws -> [Models.UsageRecord] {
        let context = container.viewContext
        var records = [Models.UsageRecord]()
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "UsageRecord")
        do {
            let result = try context.fetch(req)
            try result.forEach { (res) in
                if let mo = res as? NSManagedObject {
                    let usageRecord = try Models.UsageRecord(managedObject: mo)
                    records.append(usageRecord)
                } else {
                    throw Errors.generic("fetch result not NSManagedObject")
                }
            }
        } catch {
            print(error)
            throw error
        }

        return records
    }

    func deleteAllRecords() throws {
        let context = container.viewContext
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "UsageRecord")
        do {
            let result = try context.fetch(req)
            try result.forEach { (res) in
                if let mo = res as? NSManagedObject {
                    context.delete(mo)
                } else {
                    throw Errors.generic("fetch result not NSManagedObject")
                }
            }
        } catch {
            print(error)
            throw error
        }

    }
}

extension Models.UsageRecord {
    init(managedObject: NSManagedObject) throws {
        guard let volumeOfData = managedObject.value(forKey: "dataVolume") as? Double,
            let id = managedObject.value(forKey: "id") as? String,
            let quarter = managedObject.value(forKey: "quarter") as? Int, let year = managedObject.value(forKey: "year") as? Int,
            let isDecreaseOverQuarter = managedObject.value(forKey: "isDecreaseOverQuarter") as? Bool else {
                throw Errors.decodeError("unable to decode USageRecord from ManageObject")
        }

        do {
            self.volumeOfData = volumeOfData
            self.date = try Models.Date(string: "\(year)-Q\(quarter)")
            self.id = id
            self.isDecreaseOverQuarter = isDecreaseOverQuarter
        } catch {
            throw error
        }

    }
}
