//
//  ProjectsView.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/19/21.
//

import SwiftUI

struct ProjectsView: View {
    static let openTag: String? = "open"
    static let closedTag: String? = "closed"
    let showClosedProjects: Bool
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        self.projects = FetchRequest<Project>(
            entity: Project.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)],
            predicate: NSPredicate(format: "closed = %d", showClosedProjects),
            animation: nil
        )
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: Text(project.projectTitle)) {
                        ForEach(project.allItems) { item in
                            Text(item.itemTitle  )
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
        }
        .navigationViewStyle(.stack)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
