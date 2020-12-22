Class {
	#name : #WikitextArgumentContentParser,
	#superclass : #Object,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
WikitextArgumentContentParser class >> canHandle: aWikitextArgumentContentToParse [

	self subclassResponsibility
]

{ #category : #'instance creation' }
WikitextArgumentContentParser class >> toParse: aWikitextArgumentContentToParse [

	^ ( SuitableClassFinder findDirectSubclassOf: self suitableFor: aWikitextArgumentContentToParse )
		value new initializeToParse: aWikitextArgumentContentToParse
]

{ #category : #initialization }
WikitextArgumentContentParser >> initializeToParse: aWikitextArgumentContentToParse [

	self subclassResponsibility
]

{ #category : #initialization }
WikitextArgumentContentParser >> parse [

	self subclassResponsibility
]
