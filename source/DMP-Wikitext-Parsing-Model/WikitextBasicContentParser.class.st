Class {
	#name : #WikitextBasicContentParser,
	#superclass : #WikitextContentParser,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #'private - testing' }
WikitextBasicContentParser class >> canHandle: aWikitextContentToParse [

	^ ( Array
		with: ( self isTemplateContent: aWikitextContentToParse )
		with: ( self isListedContent: aWikitextContentToParse )
		with: ( self isMixedContent: aWikitextContentToParse )
		with: ( self isVariableTemplateContent: aWikitextContentToParse ) )
		allSatisfy: [ :condition | condition = false ]
]

{ #category : #'private - parsing' }
WikitextBasicContentParser >> cleanedContent [

	^ WikitextDoubleSquareBracesCleaner new clean: wikitextContentToParse
]

{ #category : #initialization }
WikitextBasicContentParser >> parse [

	^ WikitextBasicContent being: self cleanedContent
]
