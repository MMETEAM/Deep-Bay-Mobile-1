//
//  DBFileManager.swift
//  Deep Bay Mobile 1
//
//  Created by Roselle Tanner on 7/30/18.
//  Copyright © 2018 MMEDesignStudio. All rights reserved.
//

import UIKit

class DBFileManager {
    static let shared = DBFileManager()
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    func fileUrl(fileName: String) -> URL {
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    func filePath(fileName: String) -> String {
        return documentsDirectory.appendingPathComponent(fileName).path
    }

    func saveImage(_ image: UIImage, imageName: String) {
        let path = filePath(fileName: imageName)
        let data = UIImagePNGRepresentation(image)
        FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
    }
    
    func retrieveImage(imageName: String) -> UIImage? {
        let path = filePath(fileName: imageName)
        return FileManager.default.fileExists(atPath: path) ? UIImage(contentsOfFile: path) : nil
    }
    
    func saveMovie(_ url: URL, movieName: String) {
        let path = filePath(fileName: movieName)
        do {
            let data = try Data(contentsOf: url)
            FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retrieveMovie(movieName: String) -> URL? {
        let url = fileUrl(fileName: movieName)
        return FileManager.default.fileExists(atPath: url.path) ? url : nil
    }
}

