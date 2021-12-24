//
//  EditProjectView.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/24/21.
//

import SwiftUI

struct EditProjectView: View {
    let project: Project
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var detail : String
    @State private var color: String
    @State private var showingDeleteConfirm: Bool = false
    
    let colorColumns = [
        GridItem(.adaptive(minimum: 44.0))
    ]
    
    init(project: Project) {
        self.project = project
        
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic Settings")) {
                TextField("Project Name", text: $title.onChange(update))
                TextField("Description of project", text: $detail.onChange(update))
            }
            
            Section(header: Text("Custom Project Color")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self) { colorName in
                        ZStack {
                            Color(colorName)
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(6)
                            
                            if color == colorName {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                        }
                        .onTapGesture {
                            color = colorName
                            update()
                        }
                    }
                }
                .padding(.vertical)
            }
            
            Section(footer: Text("Closing a project moves it from the Open to the Closed tab; Deleting it removes a project entirely")) {
                Button(project.closed ? "Re-open project" : "Close project") {
                    project.closed.toggle()
                    update()
                }
                
                Button("Delete this project") {
                    showingDeleteConfirm.toggle()
                }
                .tint(.red)
            }
        }
        .navigationTitle("Edit Project")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(
                title: Text("Delete project?"),
                message: Text("Are you sure you want to delete this project? You will also delete all the items it contains."),
                primaryButton: .default(Text("Delete"), action: delete),
                secondaryButton: .cancel()
            )
        }
    }
    
    func update() {
        project.title = title
        project.detail = detail
        project.color = color
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(project: Project.example)
    }
}
