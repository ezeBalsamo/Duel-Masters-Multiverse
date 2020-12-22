Class {
	#name : #WikitextArgumentWithBasicContentParser,
	#superclass : #WikitextArgumentContentParser,
	#instVars : [
		'content'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
WikitextArgumentWithBasicContentParser class >> canHandle: aWikitextArgumentContentToParse [

	^ ( aWikitextArgumentContentToParse beginsWith: '{{' ) not
]

{ #category : #initialization }
WikitextArgumentWithBasicContentParser >> initializeToParse: aWikitextArgumentContentToParse [

	content := aWikitextArgumentContentToParse
]

{ #category : #initialization }
WikitextArgumentWithBasicContentParser >> parse [

	^ WikitextBasicContent being: content
]
