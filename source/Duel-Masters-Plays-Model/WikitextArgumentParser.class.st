Class {
	#name : #WikitextArgumentParser,
	#superclass : #Object,
	#instVars : [
		'wikitextArgumentToParse'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
WikitextArgumentParser class >> canHandle: aWikitextArgumentToParse [

	self subclassResponsibility
]

{ #category : #'instance creation' }
WikitextArgumentParser class >> toParse: aWikitextArgumentToParse [

	^ ( SuitableClassFinder findDirectSubclassOf: self suitableFor: aWikitextArgumentToParse ) value
		new initializeToParse: aWikitextArgumentToParse
]

{ #category : #initialization }
WikitextArgumentParser >> initializeToParse: aWikitextArgumentToParse [

	self subclassResponsibility
]

{ #category : #parsing }
WikitextArgumentParser >> parse [

	self subclassResponsibility
]
