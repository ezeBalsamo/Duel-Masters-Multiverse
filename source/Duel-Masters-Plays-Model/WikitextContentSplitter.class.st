Class {
	#name : #WikitextContentSplitter,
	#superclass : #Object,
	#instVars : [
		'wikitextContentsToSplit'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextContentSplitter class >> canHandle: aWikitextContentCollectionToSplit [

	self subclassResponsibility
]

{ #category : #'private - testing' }
WikitextContentSplitter class >> includesTemplateContent: aWikitextContentCollectionToSplit [

	^ aWikitextContentCollectionToSplit includesSubstring: '{{'
]

{ #category : #'private - testing' }
WikitextContentSplitter class >> isListedBasicContent: aWikitextContentCollectionToSplit [

	^ aWikitextContentCollectionToSplit
		beginsWith: Character blackSquare asString
]

{ #category : #'private - testing' }
WikitextContentSplitter class >> isTemplateContent: aWikitextContentCollectionToSplit [

	^ aWikitextContentCollectionToSplit beginsWith: '{{'
]

{ #category : #'instance creation' }
WikitextContentSplitter class >> splittingFrom: aWikitextContentCollectionToSplit [

	^ ( SuitableClassFinder
		findDirectSubclassOf: self
		suitableFor: aWikitextContentCollectionToSplit ) value new
		initializeSplittingFrom: aWikitextContentCollectionToSplit
]

{ #category : #initialization }
WikitextContentSplitter >> initializeSplittingFrom: aWikitextContentCollectionToSplit [

	wikitextContentsToSplit := aWikitextContentCollectionToSplit
]

{ #category : #splitting }
WikitextContentSplitter >> split [

	self subclassResponsibility
]
