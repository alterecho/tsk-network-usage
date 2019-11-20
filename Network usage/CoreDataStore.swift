//
//  CoreData.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 19/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import CoreData

class CoreDataStore {
    private let container: NSPersistentContainer
    init() throws {
        container = NSPersistentContainer(name: "NetworkUsage")
        container.loadPersistentStores { [weak self] (storeDescription, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            } else {
                do {
                    let record = Models.UsageRecord(volumeOfData: Models.AnyValue.numeric(10.0), date: try Models.Date(string: "1990-Q1"), id: .string("dfsfg"))
                    self?.save(record: record)
                    self?.printAll()
                } catch {
                    print(error)
                }

            }
        }
    }

//    func save(str: String) {
//        let context = container.viewContext
//        if let entity = NSEntityDescription.entity(forEntityName: "UsageRecord", in: context) {
//            let managedObject = NSManagedObject(entity: entity, insertInto: context)
//            managedObject.setValue(str, forKey: "str")
//        }
//
//        do {
//            try context.save()
//        } catch {
//            print(error)
//        }
//
//
//    }

    func printAll() {
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

    func save(record: Models.UsageRecord) {
        let context = container.viewContext
        if let entityDescription = NSEntityDescription.entity(forEntityName: "UsageRecord", in: context) {
            let managedObject = NSManagedObject(entity: entityDescription, insertInto: context)
            managedObject.setValue(record.id.stringValue, forKey: "id")
            managedObject.setValue(record.volumeOfData?.numericValue, forKey: "dataVolume")
            managedObject.setValue(record.date?.year, forKey: "year")
            managedObject.setValue(record.date?.quarter, forKey: "quarter")
            managedObject.setValue(record.isDecreaseOverQuarter, forKey: "isDecreaseOverQuarter")
        }

        do {
            try context.save()
        } catch {
            print(error)
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
            self.volumeOfData = .numeric(volumeOfData)
            self.date = try Models.Date(string: "\(year)-Q\(quarter)")
            self.id = .string(id)
            self.isDecreaseOverQuarter = isDecreaseOverQuarter
        } catch {
            throw error
        }

    }
}
