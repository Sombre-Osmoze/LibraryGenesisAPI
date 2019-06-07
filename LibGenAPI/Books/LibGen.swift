//
//  LibGen.swift
//  LibGenAPI
//
//  Created by Marcus Florentin on 05/06/2019.
//

import Foundation

public struct LibGen: Hashable, Codable {

	public let id : String

	public let title : String

	public let author : String

	public let year : String

	public let pages : String

	public let coverurl : String

	public let `extension` : String

	public let descr : String?

}
