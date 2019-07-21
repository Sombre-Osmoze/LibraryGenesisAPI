//
//  Book.swift
//  LibGenAPI
//
//  Created by Marcus Florentin on 05/06/2019.
//

import Foundation

public struct Book: Hashable, Codable {

	public let id : String

	public let title : String

	public let author : String

	public let year : String

	public let pages : String

	public let coverurl : String

	public let `extension` : Format

	public let descr : String?

	public let locator: String

	public let md5: String

	public let sha256: String

	public let filesize : String


	/// All the possible or handled file format.
	/// Types descriptions: [Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_e-book_formats)
	public enum Format: String, Codable, CaseIterable {


		/// [Portable Document Format](https://en.wikipedia.org/wiki/Portable_Document_Format)
		/// Invented by Adobe Systems, and first released in 1993,
		/// PDF became ISO 32000 in 2008.
		///
		/// The format was developed to provide a platform-independent means of exchanging fixed-layout documents.
		/// Derived from PostScript, but without language features like loops,
		/// PDF adds support for features such as compression, passwords, semantic structures and DRM.
		///
		/// Because PDF documents can easily be viewed and printed by users on a variety of computer platforms,
		/// they are very common on the World Wide Web and in document management systems worldwide.
		///
		/// The current PDF specification, ISO 32000-1:2008,
		/// is available from ISO's website, and under special arrangement, without charge from Adobe.
		/// - note: Because the format is designed to reproduce fixed-layout pages,
		/// re-flowing text to fit mobile device and e-book reader screens has traditionally been problematic.
		/// This limitation was addressed in 2001 with the release of PDF Reference 1.5 and "Tagged PDF",
		/// but 3rd party support for this feature was limited until the release of PDF/UA in 2012.
		///
		/// Many products support creating and reading PDF files, such as Adobe Acrobat, PDFCreator and OpenOffice.org,
		/// and several programming libraries such as iText and FOP.
		/// Third party viewers such as xpdf and Nitro PDF are also available.
		/// Mac OS X has built-in PDF support,
		/// both for creation as part of the printing system and for display using the built-in Preview application.
		///
		/// - important:
		/// PDF files are supported by almost all modern e-book readers, tablets and smartphones.
		/// However, PDF reflow based on Tagged PDF,
		/// as opposed to re-flow based on the actual sequence of objects in the content-stream,
		/// is not yet commonly supported on mobile devices.
		/// Such Re-flow options as may exist are usually found under "view" options, and may be called "word-wrap".
		case PDF = "pdf"

		/// [Electronic Publication](https://en.wikipedia.org/wiki/EPUB)
		/// The *.epub* or [OEBPS](https://en.wikipedia.org/wiki/Open_eBook) format
		/// is a technical standard for e-books
		/// created by the [International Digital Publishing Forum](https://en.wikipedia.org/wiki/International_Digital_Publishing_Forum)(IDPF).
		case EPUB = "epub"

		/// The [Mobipocket](https://en.wikipedia.org/wiki/Mobipocket) e-book format
		/// is based on the [Open eBook](https://en.wikipedia.org/wiki/Open_eBook) standard
		/// using [XHTML](https://en.wikipedia.org/wiki/XHTML)
		/// and can include [JavaScript](https://en.wikipedia.org/wiki/JavaScript) and frames.
		/// It also supports native [SQL](https://en.wikipedia.org/wiki/SQL) queries to be used with embedded databases.
		///
		/// - note: There is a corresponding e-book reader.
		/// The Mobipocket Reader has a home page library.
		///
		/// Readers can add blank pages in any part of a book and add free-hand drawings.
		/// Annotations – highlights, bookmarks, corrections,
		/// notes, and drawings – can be applied, organized, and recalled from a single location.
		///
		/// Images are converted to GIF format and have a maximum size of 64K,
		/// sufficient for mobile phones with small screens,
		/// but rather restrictive for newer gadgets.
		///
		/// Mobipocket Reader has electronic bookmarks, and a built-in dictionary.
		///
		/// The reader has a full screen mode for reading and support for many [PDAs](https://en.wikipedia.org/wiki/Personal_digital_assistant),
		/// [Communicators](https://en.wikipedia.org/wiki/Personal_digital_assistant),
		/// and [Smartphones](https://en.wikipedia.org/wiki/Smartphone).
		///
		/// Mobipocket products support most Windows,
		/// Symbian, BlackBerry and Palm operating systems, but not the Android platform.
		/// Using WINE, the reader works under Linux or Mac OS X.
		/// Third-party applications like [Okular](https://en.wikipedia.org/wiki/Okular)
		/// and [FBReader](https://en.wikipedia.org/wiki/FBReader) can also be used under Linux or Mac OS X,
		/// but they work only with unencrypted files.
		///
		/// - important: The Amazon Kindle's AZW format is basically just the Mobipocket format
		/// with a slightly different serial number scheme (it uses "\*" instead of "$"),
		/// and .prc publications can be read directly on the Kindle.
		///
		/// The Kindle AZW format also lacks some Mobipocket features such as JavaScript.
		///
		/// [Amazon](https://en.wikipedia.org/wiki/Amazon.com) has developed an .epub to .mobi converter called KindleGen,
		/// and it supports IDPF 1.0 and IDPF 2.0 EPUB format.
		case Mobipocket = "mobi"

		/// [Comic Book Archive](https://en.wikipedia.org/wiki/Comic_book_archive)
		/// Compressed images
		/// - important:
		/**
		 *Published as:*
		 		*.cbr (RAR)
		 		*.cbz (ZIP)
		 		*.cb7 (7z)
		 		*.cbt (TAR)
		 		*.cba (ACE)
		*/
		case cbr = "cbr"

		///	The .ibooks format is created with the free [iBooks Author](https://en.wikipedia.org/wiki/IBooks_Author)
		/// ebook layout software from [Apple Inc.](https://en.wikipedia.org/wiki/Apple_Inc.).
		///
		/// This proprietary format is based on the [EPUB](https://en.wikipedia.org/wiki/EPUB) standard,
		/// with some differences in the CSS tags used in an ibooks format file, thus making it incompatible with the EPUB specification.
		/// - note:
		/// The End-User Licensing Agreement (EULA) included with iBooks Author states that
		/// "If you want to charge a fee for a work that includes files in the .ibooks format generated using iBooks Author,
		/// you may only sell or distribute such work through Apple".
		/// The "through Apple" will typically be in the Apple [iBooks](https://en.wikipedia.org/wiki/IBooks) store.
		/// The EULA further states that "This restriction does not apply to the content of such works
		/// when distributed in a form that does not include files in the .ibooks format."
		/// Therefore,
		///
		/// Apple has not included distribution restrictions in the iBooks Author EULA
		/// for ibooks format ebooks created in iBooks Author that are made available for free,
		/// and it does not prevent authors from re-purposing the content
		/// in other ebook formats to be sold outside the iBookstore.
		///
		/// This software currently supports import and export functionally for three formats.
		/// ibook, Plain text and PDF.
		/// The iBooks Author 2.3 and later supports importing EPUB and export EPUB 3.0.
		case iBook = "ibooks"

		/// DjVu is a format specialized for storing scanned documents.
		/// It includes advanced compressors optimized for low-color images, such as text documents.
		/// Individual files may contain one or more pages. DjVu files cannot be re-flowed.
		/// - note: The contained page images are divided in separate layers (such as multi-color, low-resolution,
		/// background layer using [lossy compression](https://en.wikipedia.org/wiki/Lossy_compression),
		/// and few-colors, high-resolution, tightly compressed foreground layer), each compressed in the best available method.
		///
		/// The format is designed to decompress very quickly, even faster than vector-based formats.
		///
		/// - important: The advantage of DjVu is that it is possible to take a high-resolution scan (300–400 DPI),
		/// good enough for both on-[screen reading](https://en.wikipedia.org/wiki/Screen_reading) and printing, and store it very efficiently.
		/// Several dozens of 300 DPI black-and-white scans can be stored in less than a megabyte.
		case DjVu = "djvu"
	}
}
