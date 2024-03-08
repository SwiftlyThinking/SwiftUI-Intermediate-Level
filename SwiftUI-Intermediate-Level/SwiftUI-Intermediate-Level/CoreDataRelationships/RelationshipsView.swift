//
//  RelationshipsView.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 08.03.2024.
//

import SwiftUI

struct RelationshipsView: View {
    
    @State private var vm = RelationshipsViewModel()
    
    var body: some View {
        TabView {
            MainView()
                .tabItem { Image(systemName: "plus.square") }
            
            BusinessesView()
                .tabItem { Image(systemName: "bag.circle") }
            
            DepartmentsView()
                .tabItem { Image(systemName: "rectangle.grid.2x2") }
            
            EmployeesView()
                .tabItem { Image(systemName: "person") }
        }
        .environment(vm)
    }
}

struct MainView: View {
    
    @Environment(RelationshipsViewModel.self) var vm
    
    @State var businessName: String = ""
    @State var departmentName: String = ""
    @State var employeeName: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                VStack {
                    Text("Add Business")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Name", text: $businessName)
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(.rect(cornerRadius: 10))
                    
                    Button {
                        withAnimation(.default) {
                            vm.addBusiness(name: businessName)
                        }
                    } label: {
                        Text("Add Business")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
                
                VStack {
                    Text("Add Department")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Name", text: $departmentName)
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(.rect(cornerRadius: 10))
                    
                    Button {
                        withAnimation(.default) {
                            vm.addDepartment(name: departmentName)
                        }
                    } label: {
                        Text("Add Department")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
                
                VStack {
                    Text("Add Employee")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Name", text: $employeeName)
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(.rect(cornerRadius: 10))
                    
                    Button {
                        withAnimation(.default) {
                            vm.addEmployee(name: employeeName)
                        }
                    } label: {
                        Text("Add Employee")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
            }
            .padding()
        }
    }
}

struct BusinessesView: View {
    
    @Environment(RelationshipsViewModel.self) var vm
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.businesses) { business in
                    VStack(alignment: .leading) {
                        Text(business.name ?? "")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        if let departments = business.departments?.allObjects as? [Department] {
                            Text("Departments:")
                                .fontWeight(.semibold)
                            
                            ForEach(departments) { department in
                                Text(department.name ?? "")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.blue)
                            }
                        }
                            
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            .padding()
        }
    }
}

struct DepartmentsView: View {
    
    @Environment(RelationshipsViewModel.self) var vm
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.departments) { department in
                    VStack(alignment: .leading) {
                        Text(department.name ?? "")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        if let businesses = department.businesses?.allObjects as? [Business] {
                            Text("Businesses:")
                                .fontWeight(.semibold)
                                
                            ForEach(businesses) { business in
                                Text(business.name ?? "")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.blue)
                            }
                        }
                        
                        if let employees = department.employees?.allObjects as? [Employee] {
                            Text("Employees:")
                                .fontWeight(.semibold)
                                
                            ForEach(employees) { employee in
                                Text(employee.name ?? "")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.blue)
                            }
                        }
                            
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            .padding()
        }
    }
}

struct EmployeesView: View {
    
    @Environment(RelationshipsViewModel.self) var vm
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.employees) { employee in
                    VStack(alignment: .leading) {
                        Text(employee.name ?? "")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        if let business = employee.business {
                            Text("Department:")
                                .fontWeight(.semibold)
                            
                            Text(business.name ?? "")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.blue)
                            
                        }
                        
                        if let department = employee.department {
                            Text("Department:")
                                .fontWeight(.semibold)
                            
                            Text(department.name ?? "")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.blue)
                            
                        }
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            .padding()
        }
    }
}

#Preview {
    RelationshipsView()
}
