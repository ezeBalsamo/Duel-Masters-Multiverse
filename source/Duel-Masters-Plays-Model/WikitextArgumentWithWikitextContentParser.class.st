Class {
	#name : #WikitextArgumentWithWikitextContentParser,
	#superclass : #WikitextArgumentContentParser,
	#instVars : [
		'wikitextArgumentContentToParse'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
WikitextArgumentWithWikitextContentParser class >> canHandle: aWikitextArgumentContentToParse [

	^ aWikitextArgumentContentToParse beginsWith: '{{'
]

{ #category : #initialization }
WikitextArgumentWithWikitextContentParser >> initializeToParse: aWikitextArgumentContentToParse [

	wikitextArgumentContentToParse := aWikitextArgumentContentToParse
]

{ #category : #initialization }
WikitextArgumentWithWikitextContentParser >> parse [

	^ WikitextParser new parse: wikitextArgumentContentToParse
]
