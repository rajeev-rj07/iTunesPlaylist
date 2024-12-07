//
//  CreateNewPlaylist.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 06/12/24.
//

import SwiftUI

struct CreateNewPlaylist: View {

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @Binding var savedPlaylist: CDPlaylist?
    @Binding var showPlayListDetailsView: Bool
    @Binding var isPresented: Bool
    @FocusState private var isTextFieldFocused: Bool
    @Binding var tempNewPlaylistName: String

    @StateObject var viewModel = CreateNewPlaylistViewModel()

    var body: some View {
        ZStack {
            Color(hex: "#333333")
                .ignoresSafeArea()
            VStack {
                Text("Name your playlist.")
                    .tint(.accentColor)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .padding(.top, 150)
                TextField("Enter new name", text: $viewModel.playlistName)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .frame(width: UIScreen.screenWidth*0.8)
                    .padding(.top, 80)
                    .onSubmit {
                        
                    }
                    .submitLabel(.done)
                    .focused($isTextFieldFocused)
                Rectangle()
                    .frame(width: UIScreen.screenWidth*0.8, height: 1)
                    .padding(.bottom)
                Button {
                    if !viewModel.playlistName.trimmingCharacters(in: .whitespaces).isEmpty {
                        isPresented = false
                        tempNewPlaylistName = viewModel.playlistName
                        // Trigger navigation to FourthView after a short delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            showPlayListDetailsView = true
                        }
                        saveNewPlaylist()
                    }
                } label: {
                    Text("Confirm")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .frame(width: 140, height: 50)
                        .background(Color(hex: "#1ED760"))
                        .clipShape(Capsule())
                }
                Spacer()
            }
            .onAppear {
                // Automatically set the focus when the view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    isTextFieldFocused = true
                }
            }
        }
    }


    private func saveNewPlaylist() {
        let playlist = CDPlaylist(context: viewContext)
        playlist.id = UUID()
        playlist.name = tempNewPlaylistName

        do {
            try viewContext.save()
            savedPlaylist = playlist
        } catch {
            print("An error occured: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CreateNewPlaylist(savedPlaylist: .constant(nil), showPlayListDetailsView: .constant(false), isPresented: .constant(false), tempNewPlaylistName: .constant(""))
}
