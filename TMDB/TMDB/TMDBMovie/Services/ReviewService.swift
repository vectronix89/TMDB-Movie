//
//  ReviewService.swift
//  TMDBMovie
//
//  Created by Ahmad Ilyas on 27/06/21.
//

import Foundation
import Alamofire

// MARK: - ReviewServices
class ReviewServices: Codable {
    var id, page: Int?
    var results: [Review]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(id: Int?, page: Int?, results: [Review]?, totalPages: Int?, totalResults: Int?) {
        self.id = id
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseResult { response in
//     if let result = response.result.value {
//       ...
//     }
//   }

// MARK: - Result
class Review: Codable {
    var author: String?
    var authorDetails: AuthorDetails?
    var content, createdAt, id, updatedAt: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }

    init(author: String?, authorDetails: AuthorDetails?, content: String?, createdAt: String?, id: String?, updatedAt: String?, url: String?) {
        self.author = author
        self.authorDetails = authorDetails
        self.content = content
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.url = url
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAuthorDetails { response in
//     if let authorDetails = response.result.value {
//       ...
//     }
//   }

// MARK: - AuthorDetails
class AuthorDetails: Codable {
    var name, username: String?
    var avatarPath: String?
    var rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }

    init(name: String?, username: String?, avatarPath: String?, rating: Int?) {
        self.name = name
        self.username = username
        self.avatarPath = avatarPath
        self.rating = rating
    }
}

