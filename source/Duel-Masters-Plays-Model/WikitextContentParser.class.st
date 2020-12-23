Class {
	#name : #WikitextContentParser,
	#superclass : #Object,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
WikitextContentParser class >> canHandle: aWikitextArgumentContentToParse [

	self subclassResponsibility
]

{ #category : #'instance creation' }
WikitextContentParser class >> toParse: aWikitextArgumentContentToParse [

	| trimmedWikitextArgumentContentToParse |

	trimmedWikitextArgumentContentToParse := aWikitextArgumentContentToParse trimBoth.

	^ ( SuitableClassFinder
		findDirectSubclassOf: self
		suitableFor: trimmedWikitextArgumentContentToParse ) value new
		initializeToParse: trimmedWikitextArgumentContentToParse
]

{ #category : #initialization }
WikitextContentParser >> initializeToParse: aWikitextArgumentContentToParse [

	self subclassResponsibility
]

{ #category : #initialization }
WikitextContentParser >> parse [

	self subclassResponsibility
]
