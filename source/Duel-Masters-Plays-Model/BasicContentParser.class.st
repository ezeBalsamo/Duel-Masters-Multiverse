Class {
	#name : #BasicContentParser,
	#superclass : #WikitextContentParser,
	#instVars : [
		'content'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
BasicContentParser class >> canHandle: aWikitextArgumentContentToParse [

	^ ( aWikitextArgumentContentToParse beginsWith: '{{' ) not
]

{ #category : #'parsing - private' }
BasicContentParser >> contentWithoutDoubleSquareBraces [

	^ ( CollectionFormatter separatingWith: '' ) format: ( content findBetweenSubstrings: '[[]]' )
]

{ #category : #initialization }
BasicContentParser >> initializeToParse: aWikitextArgumentContentToParse [

	content := aWikitextArgumentContentToParse
]

{ #category : #initialization }
BasicContentParser >> parse [

	^ WikitextBasicContent being: self contentWithoutDoubleSquareBraces
]
