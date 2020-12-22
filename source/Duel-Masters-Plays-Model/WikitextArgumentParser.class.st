Class {
	#name : #WikitextArgumentParser,
	#superclass : #Object,
	#instVars : [
		'wikitextToParse'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
WikitextArgumentParser class >> canHandle: aWikitextArgumentToParse [

	self subclassResponsibility
]

{ #category : #'instance creation' }
WikitextArgumentParser class >> toParse: aWikitextArgumentToParse [

	^ ( SuitableClassFinder findSubclassOf: self suitableFor: aWikitextArgumentToParse ) value new
		initializeToParse: aWikitextArgumentToParse
]

{ #category : #initialization }
WikitextArgumentParser >> initializeToParse: aWikitextArgumentToParse [

	self subclassResponsibility
]

{ #category : #parsing }
WikitextArgumentParser >> parse [

	self subclassResponsibility
]
