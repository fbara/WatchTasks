//
//  ToDoListView.swift
//  ToDoListView
//
//  Created by Frank Bara on 9/16/21.
//

import SwiftUI

struct ToDoListView: View {
    
    var accentColor: String
    var folderName: String
    
    @FetchRequest var results: FetchedResults<ToDo>
    
    init(folderName: String, accentColor: String) {
        self.accentColor = accentColor
        self.folderName = folderName
        
        let predicate = NSPredicate(format: "folder == %@", folderName)
        self._results = FetchRequest(entity: ToDo.entity(),
                                     sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.dateAdded, ascending: false)],
                                     predicate: predicate,
                                     animation: .easeInOut)
    }
    
    var body: some View {
        List {
            ForEach(results) { item in
                HStack {
                    NavigationLink(destination: Text("Update todo"),
                                   label: {
                        Text(item.title ?? "")
                            .bold()
                    })
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .contentShape(Rectangle())
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(LinearGradient(gradient: Gradient(colors: [Color(accentColor), Color(accentColor).opacity(0.8), Color(accentColor)]), startPoint: .top, endPoint: .bottom), lineWidth: 4)
                        )
                }
            }
            
            NavigationLink(destination: Text("Add new todo"),
                           label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("New ToDo")
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(accentColor))
                        .frame(height: 40)
                )
            })
        }
        .listStyle(CarouselListStyle())
        .navigationTitle(folderName)
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(folderName: "Temp", accentColor: "#FFFF00")
    }
}
