//
//  ImportRouter.swift
//  PrivateVault
//
//  Created by Emilio Peláez on 26/04/22.
//

import SwiftUI
import SharedUI

struct ImportRouter: ViewModifier {
	@State var importAction: ImportType?
	
	func body(content: Content) -> some View {
		content
			.handleEvent(ImportEvent.self) { importAction = $0.type }
			.fileImporter(isPresented: $importAction.for(.document), allowedContentTypes: [.item], allowsMultipleSelection: true) { _ in }
	}
}

extension View {
	func importRouter() -> some View {
		modifier(ImportRouter())
	}
}

extension Binding where Value == ImportType? {
	func `for`(_ type: ImportType) -> Binding<Bool> {
		Binding<Bool> {
			self.wrappedValue == type
		} set: { _ in
			self.wrappedValue = nil
		}

	}
}
