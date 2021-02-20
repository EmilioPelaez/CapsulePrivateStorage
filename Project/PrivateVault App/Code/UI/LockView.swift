//
//  LockView.swift
//  PrivateVault
//
//  Created by Emilio Peláez on 20/2/21.
//

import SwiftUI

struct LockView: View {
	let password = "1234"
	@Binding var isUnlocked: Bool
	@State var code: String = ""
	@State var isIncorrect: Bool = false
	let maxDigits: Int = 4
	
	var body: some View {
		ZStack {
			Color(.systemBackground).ignoresSafeArea()
			VStack(spacing: 25) {
				InputDisplay(codeLength: maxDigits, input: $code, textColor: isIncorrect ? .red : .primary)
					.shake(isIncorrect, distance: 10, count: 4)
				KeypadView(input: input, delete: delete)
			}
			.frame(maxWidth: 280)
		}
	}
	
	func input(_ string: String) {
		guard code.count < maxDigits else { return }
		code.append(string)
		if code.count == password.count {
			if code == password {
				isUnlocked = true
			} else {
				withAnimation {
					isIncorrect = true
				}
			}
		}
	}
	
	func delete() {
		code.removeLast()
		isIncorrect = false
	}
	
}

struct LockView_Previews: PreviewProvider {
	static var previews: some View {
		LockView(isUnlocked: .constant(false))
	}
}
