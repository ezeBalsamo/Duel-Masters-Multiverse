Class {
	#name : #TemplateContentParser,
	#superclass : #WikitextContentParser,
	#instVars : [
		'wikitextArgumentContentToParse'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
TemplateContentParser class >> canHandle: aWikitextArgumentContentToParse [

	^ aWikitextArgumentContentToParse beginsWith: '{{'
]

{ #category : #initialization }
TemplateContentParser >> initializeToParse: aWikitextArgumentContentToParse [

	wikitextArgumentContentToParse := aWikitextArgumentContentToParse
]

{ #category : #initialization }
TemplateContentParser >> parse [

	^ WikitextParser parse: wikitextArgumentContentToParse
]
