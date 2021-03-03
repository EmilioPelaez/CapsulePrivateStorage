//
//  GalleryGridView.swift
//  PrivateVault
//
//  Created by Emilio Peláez on 20/2/21.
//

import SwiftUI

struct GalleryGridView<M: View>: View {
	@EnvironmentObject private var settings: UserSettings
	@FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \StoredItem.timestamp, ascending: false)], animation: .default)
	var data: FetchedResults<StoredItem>
	
	@ObservedObject var filter: ItemFilter
	@Binding var multipleSelection: Bool
	@Binding var selectedItems: Set<StoredItem>
	
	let selection: (StoredItem) -> Void
	let contextMenu: (StoredItem) -> M

	var filteredData: [StoredItem] {
		data.filter(filter.apply)
	}
	
	var searchText: Binding<String> {
		Binding(get: {
			filter.searchText
		}, set: {
			filter.searchText = $0
		})
	}

	var body: some View {
		if data.isEmpty {
			VStack {
				SearchBarView(text: searchText, placeholder: "Search files...")
				ZStack {
					Color.clear
					EmptyGalleryView()
						.frame(maxWidth: 280)
						.transition(.opacity)
				}
			}
		} else if filteredData.isEmpty {
			VStack {
				SearchBarView(text: searchText, placeholder: "Search files...")
				ZStack {
					Color.clear
					FilteredGalleryView {
						withAnimation { filter.clear() }
					}
					.frame(maxWidth: 280)
					.transition(.opacity)
				}
			}
		} else {
			ScrollView {
				SearchBarView(text: searchText, placeholder: "Search files...")
				LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: settings.columns), spacing: 4) {
					ForEach(filteredData) { item in
						GalleryGridCell(item: item, selection: selection(for: item))
							.onTapGesture { selection(item) }
							.contextMenu { contextMenu(item) }
					}
				}
				.padding(4)
				.padding(.bottom, 55)
			}
		}
	}
	
	func selection(for item: StoredItem) -> GalleryGridCell.Selection {
		guard multipleSelection else {
			return .disabled
		}
		return selectedItems.contains(item) ? .selected: .unselected
	}
}

struct GalleryGridView_Previews: PreviewProvider {
	static let preview = PreviewEnvironment()
	
	static var previews: some View {
		GalleryGridView(filter: ItemFilter(), multipleSelection: .constant(false), selectedItems: .constant([]), selection: { _ in }, contextMenu: { _ in EmptyView() })
			.environment(\.managedObjectContext, preview.context)
			.environmentObject(preview.controller)
			.environmentObject(UserSettings())
	}
}
