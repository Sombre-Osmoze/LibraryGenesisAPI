//
//  Books.swift
//  LibGenAPI
//
//  Created by Marcus Florentin on 06/06/2019.
//

import Foundation

public protocol Book: Hashable, Codable {

	var id : String { get }

	var title : String { get }

	var author : String { get }

	var year : String { get }

	var pages : String { get }

}
