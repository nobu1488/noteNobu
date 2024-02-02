//
//  ContentView.swift
//  noteNobu
//
//  Created by Andrey Nobu on 02.02.2024.
//

import SwiftUI

struct NotesView: View {
    @Binding var note: String
    @State private var text = ""

    var body: some View {
        TextField("Enter text", text: $text)
            .padding()
            .navigationTitle(note)
            .onAppear()
        {
            text = UserDefaults.standard.string(forKey:note) ?? ""
        }
        .onDisappear(){
                UserDefaults.standard.set(text,forKey: note)
            }
    }
}
    
struct ContentView: View {
    @State private var notes = ["заметка 1"]
    var body: some View {
        
        NavigationView {
            List {
                ForEach(notes, id: \.self) { item in
                    NavigationLink(destination: NotesView(note: $notes[notes.firstIndex(of: item)!])) {
                        Text(item)
                    }
                }
                .onDelete(perform: deleteNote)
                .onAppear(){
                    notes = UserDefaults.standard.array(forKey: "notes") as? [String] ?? ["Заметка 1"]
                }
            }
            
            .navigationBarItems(trailing: Button(action: addNote) {
                Image(systemName: "plus")
            })
            .navigationBarTitle("Список заметок")
        }
    }
    func addNote() {
        let newNote = "Заметка \(notes.count + 1)"
        notes.append(newNote)
        UserDefaults.standard.set(notes,forKey:"notes")
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
            UserDefaults.standard.set(notes,forKey:"notes")
    }

}

#Preview {
    ContentView()
}
