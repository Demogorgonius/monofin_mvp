//
//  FireStoreManager.swift
//  monofin_mvp
//
//  Created by Sergey on 09.02.2021.
//

import Foundation
import Firebase
import FirebaseStorage

protocol FireStoreProtocol {
    func saveAvatar(photo: UIImage, uid: String, completion: @escaping (Result<URL, Error>) -> Void)
    func getAvatar(url: String, completion: @escaping  (Result<UIImage, Error>) -> Void)
    func deleteAvatar(url: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class FireStoreManager: FireStoreProtocol {
    
    func saveAvatar(photo: UIImage, uid: String, completion: @escaping (Result<URL, Error>) -> Void) {
        
        let ref = Storage.storage().reference().child("avatars").child(uid)
        guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        ref.putData(imageData, metadata: metadata) {(metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            ref.downloadURL { (url, error) in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
        
    }
    
    func getAvatar(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        let ref = Storage.storage().reference(forURL: url)
        let megaByte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megaByte) { (data, error) in
            guard let imageData = data else {
                completion(.failure(error!))
                return
            }
            let image = UIImage(data: imageData)
            completion(.success(image!))
            
        }
        
    }
    
    func deleteAvatar(url: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let ref = Storage.storage().reference(forURL: url)
        ref.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true)) }
        }
        
    }
    
}
