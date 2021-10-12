//
//  Nestable.swift
//  PrivateVault
//
//  Created by Elena Meneghini on 11/08/2021.
//

protocol Nestable {
	func belongs(to folder: Folder) -> Bool
	func canBelong(to folder: Folder) -> Bool
	func add(to folder: Folder, persistenceController: PersistenceManager)
	func remove(from folder: Folder, persistenceController: PersistenceManager)
}

extension StoredItem: Nestable {
	func belongs(to folder: Folder) -> Bool {
		folder == self.folder
	}
	
	func canBelong(to folder: Folder) -> Bool {
		true
	}
	
	func add(to folder: Folder, persistenceController: PersistenceManager) {
		self.folder = folder
		folder.items?.adding(self)
		persistenceController.save()
	}
	
	func remove(from _: Folder, persistenceController: PersistenceManager) {
		folder = nil
		persistenceController.save()
	}
}

extension Folder: Nestable {
	func belongs(to folder: Folder) -> Bool {
		parent == folder
	}
	
	func canBelong(to folder: Folder) -> Bool {
		if folder == self { return false }
		guard let parent = folder.parent else { return true }
		return canBelong(to: parent)
	}
	
	func add(to folder: Folder, persistenceController: PersistenceManager) {
		parent = folder
		folder.subfolders?.adding(self)
		persistenceController.save()
	}
	
	func remove(from _: Folder, persistenceController: PersistenceManager) {
		parent = nil
		persistenceController.save()
	}
}