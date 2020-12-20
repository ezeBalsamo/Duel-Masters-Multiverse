Class {
	#name : #UnnamedWikitextArgumentParser,
	#superclass : #WikitextArgumentParser,
	#instVars : [
		'content'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
UnnamedWikitextArgumentParser class >> canHandle: aWikitextArgumentToParse [

	^ ( aWikitextArgumentToParse includesSubstring: '=' ) not
]

{ #category : #initialization }
UnnamedWikitextArgumentParser >> initializeToParse: aWikitextArgumentToParse [

	content := aWikitextArgumentToParse
]

{ #category : #parsing }
UnnamedWikitextArgumentParser >> parse [

	^ WikitextArgument unnamedWithContent: content
]
