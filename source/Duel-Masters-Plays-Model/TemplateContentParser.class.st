Class {
	#name : #TemplateContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
TemplateContentParser class >> canHandle: aWikitextContentToParse [

	^ ( self isTemplateContent: aWikitextContentToParse )
		and: [ ( self isMultipleTemplateContent: aWikitextContentToParse ) not ]
]

{ #category : #initialization }
TemplateContentParser >> parse [

	^ WikitextParser parse: wikitextContentToParse
]
