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

	private var dateFormat : DateFormatter {
		let format = DateFormatter()

		format.dateStyle = .short
		format.timeStyle = .none
		format.dateFormat = "yyyy-dd-MM"
		format.string(from: Date())
		return format
	}



	private let endpoint = Enpoints()

	public func libGens(from first: Date, to last: Date = Date(), limit: Int = 100,
				 handler: @escaping(Result<[Book], Error>) -> Void) -> Void {

		os_signpost(.begin, log: logging, name: "LibGens fetching", "From %s to %s", first.description, last.description)
		let from = dateFormat.string(from: first)
		let to = dateFormat.string(from: last)
		let path = "http://libgen.io/json.php?lg_topic=libgen&mode=last&timefirst=2018-09-02&timelast=2018-09-02&limit1=100"
//		let path = "http://booksdescr.org/json.php?lg_topic=libgen&mode=last&timefirst=\(from)&timelast=\(to)&limit1=20"
		session.dataTask(with: URL(string: path)!) { (data, anwser, error) in

			do {
				// TODO: Verify error, response, data
				handler(.success(try JSONDecoder().decode([Book].self, from: data!)))
			} catch let err {
				print(err)
			}

			os_signpost(.end, log: self.logging, name: "LibGens fetching")
		}.resume()

	}

	
	// MARK: - File Handling

	public func download(_ book: Book, progress watcher: @escaping(Double) -> Void, handler: @escaping(Result<Data, Error>)->Void) -> Void {

		var items : [URLQueryItem] = [.init(name: "md5", value: book.md5)]

		os_signpost(.begin, log: logging, name: "Fetching a book", "Named: %s", book.id)
		watcher(0.1)

		let urlT: URL = endpoint.endpoint(.file, query: items)
		session.dataTask(with: urlT) { (data, response, error) in
			watcher(0.2)
			if error == nil, let resp = response as? HTTPURLResponse, resp.statusCode == 200, let page = String(data: data!, encoding: .utf8) {
				let regex = try! NSRegularExpression(pattern: "key=[A-Z-0-9]{16}", options: [])

				let results = regex.matches(in: page,
											range: NSRange(page.startIndex..., in: page))
				watcher(0.3)
				let key = results.map {
					String(page[Range($0.range, in: page)!])
				}.first?.replacingOccurrences(of: "key=", with: "")

				items.append(.init(name: "key", value: key))
				watcher(0.4)
				let download = self.session.downloadTask(with: self.endpoint.endpoint(.file, query: items)) { (link, response, error) in
					watcher(0.6)
					do {
						if error == nil, let resp = response as? HTTPURLResponse, resp.statusCode == 200, let url = link {
							watcher(0.7)
							let data = try Data(contentsOf: url)
							os_signpost(.event, log: self.logging, name: "Fetching a book", "Received: %d bytes", data.count)
							watcher(0.1)
							handler(.success(data))
						} else {
							throw error!
						}
					} catch let err {
						os_signpost(.event, log: self.logging, name: "Fetching a book", "Error: %s", err.localizedDescription)
						handler(.failure(err))
					}
					os_signpost(.end, log: self.logging, name: "Fetching a book", "Named: %s", book.id)
				}
//				_ = download.progress.observe(\.fractionCompleted) { (prog, value) in
//					print(value)
//					if let update = value.newValue ?? value.oldValue {
//						watcher(update)
//					}
//				}
				download.resume()
			} else {
				handler(.failure(error!))
			}
			watcher(0.5)
		}.resume()
	}

}
