//
//  PersistenceController+ContextOperations.swift
//  PrivateVault
//
//  Created by Emilio Peláez on 25/2/21.
//

import CoreData

extension PersistenceController {
	func delete(_ object: NSManagedObject) {
		context.delete(object)
		save()
	}
	
	func save() {
		guard context.hasChanges else { return }
		do {
			try context.save()
		} catch {
			print(error)
		}
	}
}