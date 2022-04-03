//
//  ChangePasscodeRouter.swift
//  Settings
//
//  Created by Emilio Peláez on 03/04/22.
//

import HierarchyResponder
import LockScreen
import SwiftUI

struct ChangePasscodeRouter: ViewModifier {
	@State var changePasscode = false
	
	func body(content: Content) -> some View {
		content
			.handleEvent(ResetPasscodeEvent.self) {
				changePasscode = true
			}
			.sheet(isPresented: $changePasscode) {
				PasscodeSetScreen()
					.receiveEvent(PasscodeSetEvent.self) {
						changePasscode = false
						return .notHandled
					}
			}
	}
}

extension View {
	func changePasscodeRouter() -> some View {
		modifier(ChangePasscodeRouter())
	}
}
