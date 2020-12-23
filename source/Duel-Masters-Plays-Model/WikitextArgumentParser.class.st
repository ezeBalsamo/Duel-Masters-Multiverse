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

	| trimmedWikitextArgumentToParse |

	trimmedWikitextArgumentToParse := aWikitextArgumentToParse trimBoth.

	^ ( SuitableClassFinder findSubclassOf: self suitableFor: trimmedWikitextArgumentToParse ) value
		new initializeToParse: trimmedWikitextArgumentToParse
]

{ #category : #initialization }
WikitextArgumentParser >> initializeToParse: aWikitextArgumentToParse [

	self subclassResponsibility
]

{ #category : #parsing }
WikitextArgumentParser >> parse [

	self subclassResponsibility
]
