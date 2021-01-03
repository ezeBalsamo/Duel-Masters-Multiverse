Class {
	#name : #WikitextListedBasicContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextListedBasicContentParser class >> canHandle: aWikitextContentToParse [

	^ ( self isListedBasicContent: aWikitextContentToParse )
		and: [ ( self isMixedContent: aWikitextContentToParse ) not ]
]

{ #category : #'private - parsing' }
WikitextListedBasicContentParser >> cleanedContent [

	^ WikitextConfigurableCleaner new
		configureBlackSquareCleaner;
		configureWhiteSpacesCleaner;
		configureDoubleSquareBracesCleaner;
		clean: wikitextContentToParse
]

{ #category : #initialization }
WikitextListedBasicContentParser >> parse [

	^ WikitextBasicContent being: self cleanedContent
]
