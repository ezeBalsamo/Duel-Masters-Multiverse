Class {
	#name : #WikitextTemplateAsContentParser,
	#superclass : #WikitextContentParser,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #'private - testing' }
WikitextTemplateAsContentParser class >> canHandle: aWikitextContentToParse [

	^ ( self isTemplateContent: aWikitextContentToParse )
		and: [ ( self isMixedContent: aWikitextContentToParse ) not
				and: [ ( self isVariableTemplateContent: aWikitextContentToParse ) not ]
			]
]

{ #category : #initialization }
WikitextTemplateAsContentParser >> parse [

	^ WikitextParser parse: wikitextContentToParse
]
