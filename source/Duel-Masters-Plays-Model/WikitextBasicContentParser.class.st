Class {
	#name : #WikitextBasicContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextBasicContentParser class >> canHandle: aWikitextContentToParse [

	^ ( self isTemplateContent: aWikitextContentToParse ) not
		or: [ self isListedBasicContent: aWikitextContentToParse ]
]

{ #category : #parsing }
WikitextBasicContentParser class >> parse: aWikitextContentToParse [

	^ ( self new initializeToParse: aWikitextContentToParse ) parse
]

{ #category : #'parsing - private' }
WikitextBasicContentParser >> contentWithoutBlackSquare [

	^ wikitextContentToParse withoutPrefix: Character blackSquare asString
]

{ #category : #'parsing - private' }
WikitextBasicContentParser >> contentWithoutBlackSquareAndDoubleSquareBraces [

	^ ( CollectionFormatter separatingWith: '' )
		format: ( self contentWithoutBlackSquare trimLeft findBetweenSubstrings: '[[]]' )
]

{ #category : #initialization }
WikitextBasicContentParser >> parse [

	^ WikitextBasicContent being: self contentWithoutBlackSquareAndDoubleSquareBraces
]
