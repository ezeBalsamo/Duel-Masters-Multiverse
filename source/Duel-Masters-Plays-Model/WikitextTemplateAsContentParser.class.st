Class {
	#name : #WikitextTemplateAsContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextTemplateAsContentParser class >> canHandle: aWikitextContentToParse [

	^ ( self isTemplateContent: aWikitextContentToParse )
		and: [ ( self isMixedContent: aWikitextContentToParse ) not
				and: [ ( self isTemplateVariableContent: aWikitextContentToParse ) not ]
			]
]

{ #category : #initialization }
WikitextTemplateAsContentParser >> parse [

	^ WikitextParser parse: wikitextContentToParse
]
