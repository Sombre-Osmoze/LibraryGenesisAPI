//
//  Enpoints.swift
//  LibGenAPI
//
//  Created by Marcus Florentin on 05/06/2019.
//

import Foundation

struct Enpoints {

	private let main = URL(string: "http://libgen.io/")!

	private var dateFormatter : DateFormatter {
		let format = DateFormatter()
		format.timeStyle = .none
		format.dateStyle = .short
		format.locale = .init(identifier: "GMT")
		return format
	}

	enum Routes {
		case libGen
	}

	private func query() -> URLComponents {
		var components = URLComponents(url: main, resolvingAgainstBaseURL: true)!
//		components.

		return components
	}

	internal func enpoint(_ route: Routes, from first: Date, to last: Date) -> URL {
		var comps = query()
		


//		comps.percentEncodedQueryItems?.append(URLQueryItem(name: <#T##String#>, value: <#T##String?#>))

		return comps.url!
	}

}
