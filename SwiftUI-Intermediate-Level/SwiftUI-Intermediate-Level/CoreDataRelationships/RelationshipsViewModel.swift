//
//  RelationshipsViewModel.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 08.03.2024.
//

import Foundation
import CoreData

@Observable class RelationshipsViewModel {
    
    @ObservationIgnored private var coreDataManager = CoreDataManager.shared
    
    var businesses: [Business] = []
    var departments: [Department] = []
    var employees: [Employee] = []
    
    init() {
        getData()
    }
    
    func getData() {
        if let fetchedBusinesses = coreDataManager.fetchData(entityType: Business.self, entityName: "Business"), !fetchedBusinesses.isEmpty {
            businesses = fetchedBusinesses
        }
        
        if let fetchedDepartments = coreDataManager.fetchData(entityType: Department.self, entityName: "Department"), !fetchedDepartments.isEmpty {
            departments = fetchedDepartments
        }
        
        if let fetchedEmployees = coreDataManager.fetchData(entityType: Employee.self, entityName: "Employee"), !fetchedEmployees.isEmpty {
            employees = fetchedEmployees
        }
    }
    
    func addBusiness(name: String) {
        coreDataManager.addData(entityType: Business.self) { business in
            business.name = name
            business.departments = [departments[0], departments[1]]
        }
        
        getData()
    }
    
    func addDepartment(name: String) {
        coreDataManager.addData(entityType: Department.self) { department in
            department.name = name
        }
        
        getData()
    }
    
    func addEmployee(name: String) {
        coreDataManager.addData(entityType: Employee.self) { employee in
            employee.name = name
            employee.business = businesses[1]
            employee.department = departments[0]
        }
        
        getData()
    }
}
