//
//  Photo.swift
//  Swift Photo Viewer
//
//  Created by Yong Su on 3/31/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

struct Photo {
    
    let name: String
    let url: String
    
    init(info: [String: Any]) {
        self.name = info["name"] as! String
        self.url = info["imageURL"] as! String
    }
    
}
