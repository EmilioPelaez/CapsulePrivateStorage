//
//  SoundEffect.swift
//  PrivateVault
//
//  Created by Daniel Behar on 2/20/21.
//

import Foundation
import AVFoundation

// swiftlint:disable number_separator
enum SoundEffect {
	case success
	case failure
	case none

	func play() {
		switch self {
		case .success:
			AudioServicesPlaySystemSound(1115)
		case .failure:
			AudioServicesPlaySystemSound(1109)
		case .none:
			break
		}
	}
}
