Class {
	#name : #WikitextArgumentsSplitter,
	#superclass : #Object,
	#instVars : [
		'wikitextArgumentsToSplit',
		'splittedArguments',
		'notFullyClosedSplittedArguments'
	],
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #'private - preconditions' }
WikitextArgumentsSplitter class >> assertNotEmpty: aWikitextArgumentCollectionToSplit [

	AssertionChecker
		refuse: [ aWikitextArgumentCollectionToSplit isEmpty ]
		because: 'A collection of wikitext arguments to split was expected.'
		raising: ParsingFailed
]

{ #category : #'instance creation' }
WikitextArgumentsSplitter class >> splitting: aWikitextArgumentCollectionToSplit [

	self assertNotEmpty: aWikitextArgumentCollectionToSplit.
	^ self new initializeSplitting: aWikitextArgumentCollectionToSplit
]

{ #category : #'private - accessing' }
WikitextArgumentsSplitter >> addAsNotFullyClosed: aSplittedArgumentToBeMerged [

	notFullyClosedSplittedArguments add: aSplittedArgumentToBeMerged.
	self tryToMergeSplittedArguments
]

{ #category : #'private - accessing' }
WikitextArgumentsSplitter >> addAsSplitted: aWikitextArgumentToParse [

	splittedArguments add: aWikitextArgumentToParse
]

{ #category : #'private - asserting' }
WikitextArgumentsSplitter >> assertThereIsNoRemainingNotFullyClosedSplittedArgument [

	notFullyClosedSplittedArguments
		ifNotEmpty: [ ParsingFailed signal: #'The arguments were not splitted and merged correctly.' ]
]

{ #category : #'private - accessing' }
WikitextArgumentsSplitter >> closeCurlyBracesOccurrencesQuantityOf: aSplittedArgumentToBeMerged [

	^ aSplittedArgumentToBeMerged occurrencesQuantityOf: '}}'
]

{ #category : #initialization }
WikitextArgumentsSplitter >> initializeSplitting: aWikitextArgumentCollectionToSplit [

	wikitextArgumentsToSplit := aWikitextArgumentCollectionToSplit.
	splittedArguments := OrderedCollection new.
	notFullyClosedSplittedArguments := OrderedCollection new
]

{ #category : #'private - testing' }
WikitextArgumentsSplitter >> isNotFullyClosed: aPotentialSplittedArgument [

	^ ( self openCurlyBracesOccurrencesQuantityOf: aPotentialSplittedArgument )
		~= ( self closeCurlyBracesOccurrencesQuantityOf: aPotentialSplittedArgument )
]

{ #category : #'private - testing' }
WikitextArgumentsSplitter >> isSuitableForMerging [

	| argumentsToMerge lastArgumentToMerge extraOpenCurlyBraces extraCloseCurlyBraces |

	^ notFullyClosedSplittedArguments size > 1
		then: [ argumentsToMerge := notFullyClosedSplittedArguments allButLast.
			lastArgumentToMerge := notFullyClosedSplittedArguments last trimmed.

			extraOpenCurlyBraces := argumentsToMerge
				sumNumbers: [ :argumentToMerge | 
					( self openCurlyBracesOccurrencesQuantityOf: argumentToMerge )
						- ( self closeCurlyBracesOccurrencesQuantityOf: argumentToMerge )
					].

			extraCloseCurlyBraces := ( self
				closeCurlyBracesOccurrencesQuantityOf: lastArgumentToMerge )
				- ( self openCurlyBracesOccurrencesQuantityOf: lastArgumentToMerge ).

			extraOpenCurlyBraces = extraCloseCurlyBraces
			]
		otherwise: [ false ]
]

{ #category : #'private - merging' }
WikitextArgumentsSplitter >> mergeSplittedArguments [

	| mergedArguments |

	mergedArguments := ( CollectionFormatter separatingWith: '|' )
		format: notFullyClosedSplittedArguments.
	self addAsSplitted: mergedArguments.
	notFullyClosedSplittedArguments removeAll
]

{ #category : #'private - accessing' }
WikitextArgumentsSplitter >> openCurlyBracesOccurrencesQuantityOf: aSplittedArgumentToBeMerged [

	^ aSplittedArgumentToBeMerged occurrencesQuantityOf: '{{'
]

{ #category : #'private - testing' }
WikitextArgumentsSplitter >> shouldAddAsNotFullyClosed: aPotentialSplittedArgument [

	^ notFullyClosedSplittedArguments notEmpty
		or: [ self isNotFullyClosed: aPotentialSplittedArgument ]
]

{ #category : #splitting }
WikitextArgumentsSplitter >> split [

	( wikitextArgumentsToSplit splitOn: '|' )
		do: [ :potentialSplittedArgument | 
			( self shouldAddAsNotFullyClosed: potentialSplittedArgument )
				then: [ self addAsNotFullyClosed: potentialSplittedArgument ]
				otherwise: [ self addAsSplitted: potentialSplittedArgument ]
			].
	self assertThereIsNoRemainingNotFullyClosedSplittedArgument.
	^ splittedArguments
]

{ #category : #'private - merging' }
WikitextArgumentsSplitter >> tryToMergeSplittedArguments [

	self isSuitableForMerging
		ifTrue: [ self mergeSplittedArguments ]
]
