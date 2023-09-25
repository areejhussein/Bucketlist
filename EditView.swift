//
//  EditView.swift
//  Bucketlist
//
//  Created by Areej Hussein on 28/12/2022.
//

import SwiftUI

struct EditView: View {
    @StateObject var editViewModel: EditViewModel
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $editViewModel.name)
                    TextField("Description", text: $editViewModel.description)
                }
                Section("Nearby") {
                    switch editViewModel.loadingState {
                    case .loading:
                        Text("Loading..")
                    case .loaded:
                        ForEach(editViewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                            
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    onSave(editViewModel.save())
                    dismiss()
                }
                .task {
                    await editViewModel.fetchNearbyPlaces()
                }
            }
        }
    }
    
    init(location: Location ,onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        _editViewModel = StateObject(wrappedValue: EditViewModel(location: location))
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { newLocation in }
    }
}
