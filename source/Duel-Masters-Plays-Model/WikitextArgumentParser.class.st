Class {
	#name : #WikitextArgumentParser,
	#superclass : #Object,
	#instVars : [
		'wikitextArgumentToParse'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextArgumentParser class >> canHandle: aWikitextArgumentToParse [

	self subclassResponsibility
]

{ #category : #'private - testing' }
WikitextArgumentParser class >> isNamed: aWikitextArgumentToParse [

	^ aWikitextArgumentToParse includesSubstring: '='
]

{ #category : #'private - testing' }
WikitextArgumentParser class >> isUnnamedArgumentWithTemplateContent: aWikitextArgumentToParse [

	^ aWikitextArgumentToParse beginsWith: '{{'
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

	wikitextArgumentToParse := aWikitextArgumentToParse
]

{ #category : #parsing }
WikitextArgumentParser >> parse [

	self subclassResponsibility
]
