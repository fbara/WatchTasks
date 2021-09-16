//
//  AddNewFolder.swift
//  AddNewFolder
//
//  Created by Frank Bara on 9/16/21.
//

import SwiftUI

struct AddNewFolder: View {
    
    @State private var folderTitle = ""
    @State private var selectedColor = "blue"
    
    private var folderColors = ["blue","orange","red","purple","yellow"]
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Folder name?", text: $folderTitle)
            
            HStack {
                ForEach(folderColors, id: \.self) { colorName in
                    Circle()
                        .fill(Color(colorName))
                        .frame(width: 20, height: 20)
                        .overlay (
                            Circle().stroke(Color.white, lineWidth: selectedColor == colorName ? 2 : 0)
                        )
                        .onTapGesture {
                            selectedColor = colorName
                        }
                        .padding(.vertical)
                }
            }
            .padding(.horizontal)
            
            Button(action: addFolder) {
                Text("Add Folder")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.orange)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .disabled(folderTitle == "")
        }
        .navigationTitle("Add New Folder")
    }
    
    private func addFolder() {
        let folder = Folder(context: context)
        
        folder.title = folderTitle
        folder.dateAdded = Date()
        folder.colorString = selectedColor
        
        do {
            try context.save()
            presentationMode.wrappedValue.dismiss()
        } catch let err {
            print(err.localizedDescription)
        }
    }
}

struct AddNewFolder_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFolder()
    }
}
