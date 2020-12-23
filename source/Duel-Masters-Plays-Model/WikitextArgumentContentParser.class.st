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

	| trimmedWikitextArgumentContentToParse |

	trimmedWikitextArgumentContentToParse := aWikitextArgumentContentToParse trimBoth.

	^ ( SuitableClassFinder
		findDirectSubclassOf: self
		suitableFor: trimmedWikitextArgumentContentToParse ) value new
		initializeToParse: trimmedWikitextArgumentContentToParse
]

{ #category : #initialization }
WikitextArgumentContentParser >> initializeToParse: aWikitextArgumentContentToParse [

	self subclassResponsibility
]

{ #category : #initialization }
WikitextArgumentContentParser >> parse [

	self subclassResponsibility
]
