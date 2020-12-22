Class {
	#name : #UnnamedWikitextArgumentWithBasicContentParser,
	#superclass : #UnnamedWikitextArgumentParser,
	#instVars : [
		'content'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
UnnamedWikitextArgumentWithBasicContentParser class >> canHandle: aWikitextArgumentToParse [

	^ ( aWikitextArgumentToParse beginsWith: '{{' ) not
		and: [ ( aWikitextArgumentToParse includesSubstring: '=' ) not ]
]

{ #category : #initialization }
UnnamedWikitextArgumentWithBasicContentParser >> initializeToParse: aWikitextArgumentToParse [

	content := aWikitextArgumentToParse
]

{ #category : #parsing }
UnnamedWikitextArgumentWithBasicContentParser >> parseContent [

	^ WikitextBasicContent being: content
]
