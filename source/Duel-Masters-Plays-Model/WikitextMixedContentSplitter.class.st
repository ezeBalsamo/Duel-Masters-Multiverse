Class {
	#name : #WikitextMixedContentSplitter,
	#superclass : #Object,
	#instVars : [
		'wikitextMixedContentsToSplit',
		'splittedWikitextContents'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - preconditions' }
WikitextMixedContentSplitter class >> assertNotEmpty: aWikitextMixedContentsToSplit [

	aWikitextMixedContentsToSplit
		ifEmpty: [ ParsingFailed
				signal: #'A collection of wikitext contents to split was expected.'
			]
]

{ #category : #'instance creation' }
WikitextMixedContentSplitter class >> splitting: aWikitextMixedContentsToSplit [

	self assertNotEmpty: aWikitextMixedContentsToSplit.
	^ self new initializeSplitting: aWikitextMixedContentsToSplit
]

{ #category : #'private - accessing' }
WikitextMixedContentSplitter >> addAsSplitted: aWikitextContentToParse [

	splittedWikitextContents add: aWikitextContentToParse.
	wikitextMixedContentsToSplit := self
		trimBrTagsAndWhiteSpacesIn:
			( wikitextMixedContentsToSplit
				withoutFirst: aWikitextContentToParse size )
]

{ #category : #initialization }
WikitextMixedContentSplitter >> initializeSplitting: aWikitextMixedContentsToSplit [

	wikitextMixedContentsToSplit := aWikitextMixedContentsToSplit.
	splittedWikitextContents := OrderedCollection new
]

{ #category : #splitting }
WikitextMixedContentSplitter >> split [

	[ wikitextMixedContentsToSplit notEmpty ]
		whileTrue: [ self splitWikitextContents ].

	^ splittedWikitextContents
]

{ #category : #'private - splitting' }
WikitextMixedContentSplitter >> splitWikitextContents [

	| splittedWikitextContent |

	splittedWikitextContent := ( WikitextContentSplitter
		splittingFrom: wikitextMixedContentsToSplit ) split.
	self addAsSplitted: splittedWikitextContent
]

{ #category : #'private - parsing' }
WikitextMixedContentSplitter >> trimBrTagsAndWhiteSpacesIn: aNotClosedWikitextTemplateToParse [

	^ WikitextConfigurableCleaner new
		configureBrTagsCleaner;
		configureWhiteSpacesCleaner;
		clean: aNotClosedWikitextTemplateToParse
]
