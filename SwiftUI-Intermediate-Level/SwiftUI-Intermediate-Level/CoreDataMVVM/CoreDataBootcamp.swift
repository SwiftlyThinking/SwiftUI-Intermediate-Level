//
//  CoreDataBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 06.03.2024.
//

import SwiftUI
import CoreData

enum Operation {
    case add
    case subtract
}

class CoreDataViewModel: ObservableObject {
    
    @Published var users: [UserEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "UsersContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Fetching error: \(error.localizedDescription)")
            }
        }
        fetchUsers()
    }
    
    func fetchUsers() {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        
        do {
            users = try container.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addUser(nickname: String, points: Int) {
        let newUser = UserEntity(context: container.viewContext)
        newUser.nickname = nickname
        newUser.points = Int64(points)
        
        saveUsers()
    }
    
    func deleteUser(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = users[index]
        container.viewContext.delete(entity)
        
        saveUsers()
    }
    
    func updateUser(user: UserEntity, operation: Operation) {
        switch operation {
        case .add:
            user.points += 1
        case .subtract:
            user.points -= 1
        }
        
        saveUsers()
    }
    
    func saveUsers() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Saving error: \(error.localizedDescription)")
        }
        
        fetchUsers()
    }
    
}

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    @State var nicknameTextField: String = ""
    @State var pointsTextField: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Nickname", text: $nicknameTextField)
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal)
                
                TextField("Points", text: $pointsTextField)
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal)
                
                Text("Save")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(isAppropriateText() ? Color.blue : Color.gray)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation(.default) {
                            saveAction()
                        }
                    }
                
                List {
                    ForEach(vm.users) { user in
                        HStack {
                            Text(user.nickname ?? "")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.primary)
                            
                            Spacer()
                            
                            Text("\(user.points)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.green)
                        }
                        .onTapGesture {
                            withAnimation(.default) {
                                vm.updateUser(user: user, operation: .subtract)
                                
                            }
                        }
                    }
                    .onDelete(perform: vm.deleteUser)
                }
                .padding()
                .listStyle(.plain)
            }
            .navigationTitle("Add User")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
    }
    
    func saveAction() {
        if isAppropriateText() {
            guard let points = Int(pointsTextField) else { return }
            vm.addUser(nickname: nicknameTextField, points: points)
            clear()
        }
    }
    
    func isAppropriateText() -> Bool {
        if nicknameTextField.count > 5 && !pointsTextField.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func clear() {
        nicknameTextField = ""
        pointsTextField = ""
    }
}

#Preview {
    CoreDataBootcamp()
}
