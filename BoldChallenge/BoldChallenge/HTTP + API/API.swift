//
//  API.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 13/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import Foundation
import UIKit

enum APIError: Error {
    case NoConnection
    case CouldNotParseResponse
    case Failure(String)
    case Unknown
}

class API {
    
    private let apiUrlString = "http://jsonplaceholder.typicode.com/"
    
    private struct EndPoints{
        let user: String = "users" // list all users -- users
        let albums: String = "albums?userId="// list all albums of a user -- albums?userId=#
        let photos: String = "photos?albumId="// list all the images of the album -- photos?albumId=#
        let posts: String = "posts?userId="// list all the posts of a user -- posts?userId=#
        let comments: String = "comments?postId=" // show all the comments of a post -- comments?postId=#
        let todos: String = "todos?userId=" // list all todos of a user -- todos?userId=#
    }
    
    private var endPoints = EndPoints()
    
    
    private let httpRequests = HTTPRequests()
    
    
    //MARK: Singleton Definition
    private static var theOnlyInstance: API?
    static var shared: API {
        get {
            if theOnlyInstance == nil {
                theOnlyInstance = API()
            }
            return theOnlyInstance!
        }
    }
    
    private init() {}
    
    // MARK: API capabilities
    
    public func fetchUsers(_ completion: @escaping ([User]?, APIError?) -> Void) {
        self.httpRequests.getHTTP(at: self.apiUrlString + endPoints.user) { (users: [User]?, error) in
            if let users = users {
                completion(users, nil)
            } else if let error = error {
                completion(nil, self.getError(from: error))
            } else {
                completion(nil, .Unknown)
            }
        }
    }
    
    public func fetchAlbumsOfUser(userId: Int,completion: @escaping ([Albums]?, APIError?) -> Void) {
        self.httpRequests.getHTTP(at: self.apiUrlString + endPoints.albums + String(userId)) { (albums: [Albums]?, error) in
            if let albums = albums {
                completion(albums, nil)
            } else if let error = error {
                completion(nil, self.getError(from: error))
            } else {
                completion(nil, .Unknown)
            }
        }
    }
    
    public func fetchPhotosOfAlbum(albumId: Int,completion: @escaping ([Photos]?, APIError?) -> Void) {
        self.httpRequests.getHTTP(at: self.apiUrlString + endPoints.photos + String(albumId)) { (photos: [Photos]?, error) in
            if let photos = photos {
                completion(photos, nil)
            } else if let error = error {
                completion(nil, self.getError(from: error))
            } else {
                completion(nil, .Unknown)
            }
        }
    }
    
    
    public func fetchPostsOfUser(userId: Int,completion: @escaping ([Posts]?, APIError?) -> Void) {
        self.httpRequests.getHTTP(at: self.apiUrlString + endPoints.posts + String(userId)) { (posts: [Posts]?, error) in
            if let posts = posts {
                completion(posts, nil)
            } else if let error = error {
                completion(nil, self.getError(from: error))
            } else {
                completion(nil, .Unknown)
            }
        }
    }
    
    public func fetchCommentsOfPost(postId: Int,completion: @escaping ([Comments]?, APIError?) -> Void) {
        self.httpRequests.getHTTP(at: self.apiUrlString + endPoints.comments + String(postId)) { (comments: [Comments]?, error) in
            if let comments = comments {
                completion(comments, nil)
            } else if let error = error {
                completion(nil, self.getError(from: error))
            } else {
                completion(nil, .Unknown)
            }
        }
    }
    
    public func fetchTodosOfUser(userId: Int,completion: @escaping ([Todos]?, APIError?) -> Void) {
        self.httpRequests.getHTTP(at: self.apiUrlString + endPoints.todos + String(userId)) { (todos: [Todos]?, error) in
            if let todos = todos {
                completion(todos, nil)
            } else if let error = error {
                completion(nil, self.getError(from: error))
            } else {
                completion(nil, .Unknown)
            }
        }
    }
    
    public func getPhoto(photoUrl: URL,completion: @escaping (Data?, APIError?) -> Void) {
        self.httpRequests.getHTTPPhoto(at: photoUrl) { (photo: Data?, error) in
            if let photo = photo {
                completion(photo, nil)
            } else if let error = error {
                completion(nil, self.getError(from: error))
            } else {
                completion(nil, .Unknown)
            }
        }
    }
    
    
    
    private func getError(from httpError: HTTPRequestsError) -> APIError {
        switch httpError {
        case .CouldNotFormURL:
            return .Failure("Faulire")
        case .CouldNotParseResponse:
            return .CouldNotParseResponse
        case .Failure(let data):
            return .Failure(data)
        case .Unknown(_):
            return .Unknown
        }
    }
    
}
