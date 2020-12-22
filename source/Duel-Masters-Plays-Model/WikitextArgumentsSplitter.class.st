Class {
	#name : #WikitextArgumentsSplitter,
	#superclass : #Object,
	#instVars : [
		'wikitextArgumentsToSplit',
		'splittedArguments'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - preconditions' }
WikitextArgumentsSplitter class >> assertNotEmpty: aWikitextArgumentCollectionToSplit [

	aWikitextArgumentCollectionToSplit
		ifEmpty: [ ParsingFailed signal: #'A collection of wikitext arguments to split was expected' ]
]

{ #category : #'instance creation' }
WikitextArgumentsSplitter class >> splitting: aWikitextArgumentCollectionToSplit [

	self assertNotEmpty: aWikitextArgumentCollectionToSplit.
	^ self new initializeSplitting: aWikitextArgumentCollectionToSplit
]

{ #category : #'accessing - private' }
WikitextArgumentsSplitter >> findCloseDoubleCurlyBracesStartingAt: anStartIndex [

	| index nestLevel |

	index := anStartIndex + 1.
	nestLevel := 1.
	index to: wikitextArgumentsToSplit size do: [ :currentIndex | 
		( wikitextArgumentsToSplit at: currentIndex ) = ${
			ifTrue: [ nestLevel := nestLevel + 1 ].
		( wikitextArgumentsToSplit at: currentIndex ) = $}
			ifTrue: [ nestLevel := nestLevel - 1 ].
		nestLevel isZero
			ifTrue: [ ^ currentIndex ]
		].

	ParsingFailed signal: 'The arguments includes ''{{'' but not ''}}'''
]

{ #category : #'testing - private' }
WikitextArgumentsSplitter >> hasWikitextContentOpenedDelimitor: aPotentialWikitextArgument [

	^ aPotentialWikitextArgument includesSubstring: '{{'
]

{ #category : #initialization }
WikitextArgumentsSplitter >> initializeSplitting: aWikitextArgumentCollectionToSplit [

	wikitextArgumentsToSplit := aWikitextArgumentCollectionToSplit.
	splittedArguments := OrderedCollection new
]

{ #category : #splitting }
WikitextArgumentsSplitter >> removeSplittedArgumentSize: aSplittedArgumentSize [

	wikitextArgumentsToSplit := wikitextArgumentsToSplit withoutFirst: aSplittedArgumentSize + 1
]

{ #category : #splitting }
WikitextArgumentsSplitter >> split [

	[ wikitextArgumentsToSplit notEmpty ] whileTrue: [ self splitNextArgument ].
	^ splittedArguments
]

{ #category : #splitting }
WikitextArgumentsSplitter >> splitNextArgument [

	| potentialFirstArgument |

	potentialFirstArgument := ( wikitextArgumentsToSplit splitOn: '|' ) first.
	^ ( self hasWikitextContentOpenedDelimitor: potentialFirstArgument )
		then: [ self splitWhenWikitextContentIsPresent ]
		otherwise: [ splittedArguments add: potentialFirstArgument.
			self removeSplittedArgumentSize: potentialFirstArgument size
			]
]

{ #category : #splitting }
WikitextArgumentsSplitter >> splitWhenWikitextContentIsPresent [

	| doubleCurlyBracesStartIndex doubleCurlyBracesFinishIndex |

	doubleCurlyBracesStartIndex := wikitextArgumentsToSplit findString: '{{'.
	doubleCurlyBracesFinishIndex := self
		findCloseDoubleCurlyBracesStartingAt: doubleCurlyBracesStartIndex.

	splittedArguments add: ( wikitextArgumentsToSplit copyFirst: doubleCurlyBracesFinishIndex ).

	self removeSplittedArgumentSize: doubleCurlyBracesFinishIndex
]
