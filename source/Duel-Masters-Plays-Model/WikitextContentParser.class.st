Class {
	#name : #WikitextContentParser,
	#superclass : #Object,
	#instVars : [
		'wikitextContentToParse'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextContentParser class >> canHandle: aWikitextContentToParse [

	self subclassResponsibility
]

{ #category : #'private - testing' }
WikitextContentParser class >> isListedBasicContent: aWikitextContentToParse [

	^ aWikitextContentToParse beginsWith: Character blackSquare asString
]

{ #category : #'private - testing' }
WikitextContentParser class >> isMixedContent: aWikitextContentToParse [

	^ ( aWikitextContentToParse splitOn: '}}' ) withoutFirst
		anySatisfy: [ :splittedContentToParse | 
			( splittedContentToParse includesSubstring: '{{' )
				or: [ splittedContentToParse includesSubstring: Character blackSquare asString ]
			]
]

{ #category : #'private - testing' }
WikitextContentParser class >> isTemplateContent: aWikitextContentToParse [

	^ aWikitextContentToParse beginsWith: '{{'
]

{ #category : #'instance creation' }
WikitextContentParser class >> toParse: aWikitextContentToParse [

	| trimmedWikitextContentToParse |

	trimmedWikitextContentToParse := aWikitextContentToParse trimBoth.

	^ ( SuitableClassFinder findDirectSubclassOf: self suitableFor: trimmedWikitextContentToParse )
		value new initializeToParse: trimmedWikitextContentToParse
]

{ #category : #initialization }
WikitextContentParser >> initializeToParse: aWikitextContentToParse [

	wikitextContentToParse := aWikitextContentToParse
]

{ #category : #initialization }
WikitextContentParser >> parse [

	self subclassResponsibility
]
