Class {
	#name : #WikitextListedContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Wikitext-Parsing-Model'
}

{ #category : #'private - testing' }
WikitextListedContentParser class >> canHandle: aWikitextContentToParse [

	^ ( self isListedContent: aWikitextContentToParse )
		and: [ ( self isMixedContent: aWikitextContentToParse ) not ]
]

{ #category : #'private - parsing' }
WikitextListedContentParser >> cleanedContent [

	^ WikitextConfigurableCleaner new
		configureBlackSquareCleaner;
		configureWhiteSpacesCleaner;
		configureDoubleSquareBracesCleaner;
		clean: wikitextContentToParse
]

{ #category : #initialization }
WikitextListedContentParser >> parse [

	^ WikitextBasicContent being: self cleanedContent
]
