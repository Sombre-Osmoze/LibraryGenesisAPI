//
//  InteractionAPI.swift
//  LibGenAPI
//
//  Created by Marcus Florentin on 05/06/2019.
//

import Foundation

// Logging
import os.log
import os.signpost


public class InteractionAPI: NSObject, URLSessionDelegate {


	/// Default event loggerp
	private var logger : OSLog! { return .init(subsystem: "com.osmoze.API42.InteractionAPI", category: .pointsOfInterest) }

	/// Logger for sign post logs
	private var logging : OSLog! { return .init(subsystem: "com.osmoze.API42.InteractionAPI", category: "Request") }

	private var session : URLSession {
		let queue = OperationQueue()
		queue.qualityOfService = .userInitiated

		let session = URLSession(configuration: .default, delegate: self, delegateQueue: queue)
		return session
	}

	 func libGens(from first: Date, to last: Date = Date(), handler: @escaping(Result<[LibGen], Error>) -> Void) -> Void {

		os_signpost(.begin, log: logging, name: "LibGens fetching", "From %s to %s", first.description, last.description)
		session.dataTask(with: URL(string: "http://libgen.io/json.php?lg_topic=libgen&mode=last&timefirst=2018-09-02&timelast=2018-09-02&limit1=100")!) { (data, anwser, error) in

			do {
				// TODO: Verify error, response, data
				handler(.success(try JSONDecoder().decode([LibGen].self, from: data!)))
			} catch let err {
				print(err)
			}

			os_signpost(.end, log: self.logging, name: "LibGens fetching")
		}.resume()

	}


}
