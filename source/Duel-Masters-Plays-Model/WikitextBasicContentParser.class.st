Class {
	#name : #WikitextBasicContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextBasicContentParser class >> canHandle: aWikitextContentToParse [

	^ ( self isTemplateContent: aWikitextContentToParse ) not
		and: [ ( self isListedBasicContent: aWikitextContentToParse ) not
				and: [ ( self isMixedContent: aWikitextContentToParse ) not ]
			]
]

{ #category : #'private - parsing' }
WikitextBasicContentParser >> cleanedContent [

	^ WikitextDoubleSquareBracesCleaner new clean: wikitextContentToParse
]

{ #category : #initialization }
WikitextBasicContentParser >> parse [

	^ WikitextBasicContent being: self cleanedContent
]
