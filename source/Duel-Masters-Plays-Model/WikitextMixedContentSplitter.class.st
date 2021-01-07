Class {
	#name : #WikitextMixedContentSplitter,
	#superclass : #Object,
	#instVars : [
		'wikitextMixedContentsToSplit'
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

{ #category : #'private - parsing' }
WikitextMixedContentSplitter >> clean: aSplittedWikitextContentToParse [

	^ WikitextConfigurableCleaner new
		configureBrTagsCleaner;
		configureWhiteSpacesCleaner;
		clean: aSplittedWikitextContentToParse
]

{ #category : #'private - merging' }
WikitextMixedContentSplitter >> complete: aSplittedButIncompleteContent [

	^ ( aSplittedButIncompleteContent includesSubstring: '}}' )
		then: [ self completeAsTemplateContent: aSplittedButIncompleteContent ]
		otherwise:
			[ self completeAsListedContent: aSplittedButIncompleteContent ]
]

{ #category : #'private - merging' }
WikitextMixedContentSplitter >> completeAsListedContent: aSplittedButIncompleteContent [

	^ '<1s><2s>'
		expandMacrosWith: String blackSquare
		with: aSplittedButIncompleteContent
]

{ #category : #'private - merging' }
WikitextMixedContentSplitter >> completeAsTemplateContent: aSplittedButIncompleteContent [

	^ '{{<1s>' expandMacrosWith: aSplittedButIncompleteContent
]

{ #category : #initialization }
WikitextMixedContentSplitter >> initializeSplitting: aWikitextMixedContentsToSplit [

	wikitextMixedContentsToSplit := aWikitextMixedContentsToSplit
]

{ #category : #splitting }
WikitextMixedContentSplitter >> split [

	| splittedButIncompleteContents |

	splittedButIncompleteContents := wikitextMixedContentsToSplit
		findBetweenSubstrings: ( Array with: '{{' with: String blackSquare ).

	^ ( splittedButIncompleteContents
		collect: [ :incompleteContent | self complete: incompleteContent ] )
		collect: [ :splittedContent | self clean: splittedContent ]
]
