//
//  Enpoints.swift
//  LibGenAPI
//
//  Created by Marcus Florentin on 05/06/2019.
//

import Foundation

struct Enpoints {

	private let main = URL(string: "http://booksdescr.org/")!

	private var dateFormatter : DateFormatter {
		let format = DateFormatter()
		format.timeStyle = .none
		format.dateStyle = .short
		format.locale = .init(identifier: "GMT")
		return format
	}

	enum Routes: String {
		case libGen = "json.php"
		case file = "get.php"
		case cover = "covers"
	}

	private func query(_ url: URL? = nil, path: String = "") -> URLComponents {
		var route = url ?? main

		if !path.isEmpty {
			route.appendPathComponent(path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")
		}
		var components = URLComponents(url: route, resolvingAgainstBaseURL: true)!
		components.queryItems = []
		return components
	}

	internal func endpoint(_ route: Routes, query items: [URLQueryItem] = []) -> URL {
		var comps = query(path: route.rawValue)
		comps.queryItems?.append(contentsOf: items)
		return comps.url!
	}

}
