//
//  AddNewTodo.swift
//  AddNewTodo
//
//  Created by Frank Bara on 9/17/21.
//

import SwiftUI

struct AddNewTodo: View {
    
    var todoItem: ToDo?
    
    var accentColor: String
    var folderName: String
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    
    @State private var todoTitle = ""
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Add new todo", text: $todoTitle, prompt: Text("Add new prompt"))
            
            Button(action: addUpdateTodo) {
                Text(todoItem == nil ? "Add Todo" : "Update")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(accentColor))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .disabled(todoTitle == "")
            
            Button(action: deleteTodo) {
                Text("Delete")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(accentColor))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .opacity(todoItem == nil ? 0.0 : 1.0)
            
        }
        .navigationTitle(todoItem == nil ? "Add Todo" : "Update Todo")
        .onAppear {
            if let todo = todoItem {
                todoTitle = todo.title ?? ""
            }
        }
    }
    
    private func addUpdateTodo() {
        let todo = todoItem == nil ? ToDo(context: context) : todoItem
        
        todo?.title = todoTitle
        todo?.dateAdded = Date()
        todo?.folder = folderName
        
        do {
            try context.save()
            presentationMode.wrappedValue.dismiss()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    private func deleteTodo() {
        if let todo = todoItem {
            context.delete(todo)
            do {
                try context.save()
            } catch let err {
                print(err.localizedDescription)
            }
            
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddNewTodo_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTodo(accentColor: "#FFFFF1", folderName: "Test folder")
    }
}
