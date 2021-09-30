//
//  MWEntry.swift
//  Typera
//
//  Created by Hunter Holland on 5/7/21.
//

import Foundation
import SwiftUI

// MARK: MWEntry
struct MWEntry: Codable {
    var meta: EntryMetadata
    var hom: HomographNumber
    var hwi: HeadwordInformation
    var ahws: AlternateHeadwords
    var vrs: [Variant]
    var fl: FunctionalLabel
    var lbs: [GeneralLabel]
    var sls: [SubjectStatusLabel]
    var ins: [Inflection]
    var cxs: CognateCrossReferences
    var def: [DefinitionSectionObject]
}

/// Information about an entry, as opposed to the actual content of the entry.
struct EntryMetadata: Codable {
    /// Unique entry identifier within a particular dictionary data set, used in cross-references pointing to the entry. It consists of the headword, and in homograph entries, an appended colon and homograph number.
    var id: String
    /// The universally unique identifier for the headword.
    var uuid: String
    /// A 9-digit code which may be used to sort entries in the proper dictionary order if alphabetical display is needed.
    var sort: String
    /// Source data set for entry—ignore.
    var src: String
    /// Indicates the section the entry belongs to in print, where "alpha" indicates the main alphabetical section, "biog" biographical, "geog" geographical, and "fw&p" the foreign words & phrases section.
    var section: String
    /// Lists all of the entry's headwords, variants, inflections, undefined entry words, and defined run-on phrases. Each stem string is a valid search term that should match this entry.
    var stems: [String]
    /// True if there is a label containing "offensive" in the entry; otherwise, false.
    var offensive: Bool
}

/// The `hom` member contains a homograph number used to mark and distinguish the identically-spelled headwords.
typealias HomographNumber = Int

/// Key headword information is grouped in an `hwi` object. This includes the headword itself in the `hw` member, and may include one or more pronunciations in `prs`.
struct HeadwordInformation: Codable {
    /// Headword (required).
    var hw: String
    /// An array of one or more pronunciation objects.
    var prs: [Pronunciation]
}

/// An array of one or more alternate headword objects.
struct AlternateHeadwords: Codable {
    /// Headword (required).
    var hw: String
    var prs: [Pronunciation]
    var psl: ParenthesizedSubjectStatusLabel
}

/// A variant is a different spelling or styling of a headword, defined run-on phrase, or undefined entry word. A set of one or more variants is contained in a `vrs`.
struct Variant: Codable {
    /// Variant (required).
    var va: String
    /// Variant label, such as “or” (optional).
    var vl: String?
    var prs: [Pronunciation]?
    var spl: SenseSpecificInflectionPluralLabel?
}

/// An object describing the pronunciation of a headword.
struct Pronunciation: Codable {
    /// Written pronunciation in Merriam-Webster format.
    var mw: String?
    /// Pronunciation label before pronunciation
    var l: String?
    /// Pronunciation label after pronunciation
    var l2: String?
    /// Punctuation to separate pronunciation objects
    var pun: String?
    var sound: SoundObject?
}

/// Audio playback information: the audio member contains the base filename for audio playback; the ref and stat members can be ignored.
struct SoundObject: Codable {
    var audio: String
    var ref: String
    var stat: String
    
    var audioURL: URL? {
        URL(string: "https://media.merriam-webster.com/audio/prons/\(language_code)/\(country_code)/\(format)/\(subdirectory)/\(base_filename).\(format)")
    }
    
    private var language_code: String = "en"
    private var country_code: String = "us"
    private var format: String = "mp3"
    private var subdirectory: String {
        if self.audio.hasPrefix("bix") {
            return "bix"
        } else if self.audio.hasPrefix("gg") {
            return "gg"
        } else if self.audio.starts(with: "PUNCTUATION OR NUMBER") {
            return "number"
        } else {
            return String(self.audio.first!)
        }
    }
    private var base_filename: String {
        self.audio
    }
}

/// Describes the grammatical function of a headword or undefined entry word, such as "noun" or "adjective". Also known as the "part of speech".
typealias FunctionalLabel = String

/// Provides information such as whether a headword is typically capitalized, used as an attributive noun, etc. A set of one or more such labels is contained in an `lbs`.
typealias GeneralLabel = String

/// Describes the subject area (eg, "computing") or regional/usage status (eg, "British", "formal", "slang") of a headword or a particular sense of a headword. A set of one or more subject/status labels is contained in an `sls`.
typealias SubjectStatusLabel = String

/// Describes the subject area or regional/usage status (eg, "British") of a headword or other defined term, and is displayed in parentheses.
typealias ParenthesizedSubjectStatusLabel = String

/// Provides information on the grammatical number (eg, singular, plural) of an inflection in a particular sense. A sense-specific inflection plural label is contained in an `spl`.
typealias SenseSpecificInflectionPluralLabel = String

/// Notes whether a particular sense of a verb is transitive (T) or intransitive (I). The sense-specific grammatical label is contained in an `sgram`.
typealias SenseSpecificGrammaticalLabel = String

/// The change of form that words undergo in different grammatical contexts, such as tense or number. A set of one or more inflections is contained in an `ins`.
struct Inflection: Codable {
    var `if`: String?
    var ifc: String
    var il: String?
    var prs: [Pronunciation]
    var spl: SenseSpecificInflectionPluralLabel?
}

typealias CognateCrossReferences = [CognateCrossReference]

/// When a headword is a less common spelling of another word with the same meaning, there will be a cognate cross-reference pointing to the headword with the more common spelling. A set of cognate cross-references is contained in a `cxs`.
struct CognateCrossReference: Codable {
    /// Cognate cross-reference label.
    var cxl: String
    var cxtis: [CognateCrossReferenceTarget]
}

struct CognateCrossReferenceTarget: Codable {
    /// Cognate cross-reference label.
    var cxl: String?
    /// When present, use as cross-reference target ID for immediately preceding `cxt`.
    var cxr: String?
    /// Provides hyperlink text in all cases, and cross-reference target ID when no immediately following `cxr`.
    var cxt: String?
    /// Sense number of cross-reference target.
    var cxn: String?
}

// MARK: - Definition Section
protocol DefinitionSectionObject: Codable { }

typealias VerbDivider = String
/// The text of the definition or translation for a particular sense. Defining text is contained in `dt`.
//struct DefiningText {
//    <#fields#>
//}

// MARK: - Verbal Illustrations
protocol VerbalIllustration { }
