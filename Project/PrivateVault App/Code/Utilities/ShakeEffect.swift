//
//  ShakeEffect.swift
//  PrivateVault
//
//  Created by Emilio Peláez on 20/2/21.
//

import SwiftUI

struct Shake: GeometryEffect {
	var distance: CGFloat = 10
	var shakeCount = 3
	var animatableData: CGFloat
	
	var translation: CGFloat {
		distance * sin(animatableData * .pi * CGFloat(shakeCount))
	}
	
	func effectValue(size: CGSize) -> ProjectionTransform {
		ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
	}
}

extension View {
	
	func shake(_ flag: Bool, distance: CGFloat = 10, count: Int = 3) -> some View {
		self.modifier(Shake(distance: distance, shakeCount: count, animatableData: flag ? 1 : 0))
	}
	
}
