//
//  FileManagerBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 11.03.2024.
//

import SwiftUI


class LocalFileManager {
    
    static let shared = LocalFileManager()
    
    private var folderName = "UserImages"
    
    private init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathExtension(folderName)
                .path
        else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(
                    atPath: path,
                    withIntermediateDirectories: false,
                    attributes: nil)
                print("Success creating folder.")
            } catch let error {
                print("Error creating folder. \(error.localizedDescription)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathExtension(folderName)
                .path
        else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success removing folder.")
        } catch let error {
            print("Error removing folder. \(error.localizedDescription)")
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathExtension(folderName)
                .appendingPathExtension("\(name).jpg")
        else {
            print("")
            return nil
        }
        
        return path
    }
    
    func saveImage(image: UIImage, name: String) {
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name)
        else {
            print("Error saving an image #1.")
            return
        }
        
        do {
            try data.write(to: path)
        } catch let error {
            print("Error saving an image #2. \(error.localizedDescription)")
        }
    }
    
    func deleteImage(name: String) {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path)
        else {
            print("Image \(name) doesn't exist.")
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Sucessfully deleted.")
        } catch let error {
            print("Error deleting image. \(error.localizedDescription)")
            return
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path)
        else {
            print("Error getting path.")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    private var localFileManager = LocalFileManager.shared
    private var imageName: String = "image"
    
    init() {
        getImage()
    }
    
    func getImage() {
        image = localFileManager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = UIImage(named: "image") else { return }
        localFileManager.saveImage(image: image, name: imageName)
        getImage()
    }
    
    func deleteImage() {
        localFileManager.deleteImage(name: imageName)
        getImage()
    }
}

struct FileManagerBootcamp: View {
    
    @StateObject private var vm = FileManagerViewModel()
    
    var body: some View {
        VStack {
            
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 300, height: 300)
            } else {
                ProgressView()
            }
            
            Spacer()
            
            HStack {
                Button {
                    vm.saveImage()
                } label: {
                    Text("Save")
                        .font(.headline)
                        .padding()
                        .frame(width: 150, height: 55)
                        .background(Color(UIColor.secondarySystemFill))
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                Button {
                    vm.deleteImage()
                } label: {
                    Text("Delete")
                        .font(.headline)
                        .padding()
                        .frame(width: 150, height: 55)
                        .background(Color(UIColor.secondarySystemFill))
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
            .padding()
        }
    }
}

#Preview {
    FileManagerBootcamp()
}
