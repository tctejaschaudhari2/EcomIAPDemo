//
//  Product.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 26/07/25.
//

struct Product : Codable {
    let id : Int?
    let title : String?
    let slug : String?
    let productId : String?
    let price : Int?
    let description : String?
    let images : [String]?
    let creationAt : String?
    let updatedAt : String?
    var isPurchased : Bool = false

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case slug = "slug"
        case productId = "productId"
        case price = "price"
        case description = "description"
        case images = "images"
        case creationAt = "creationAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        creationAt = try values.decodeIfPresent(String.self, forKey: .creationAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}
