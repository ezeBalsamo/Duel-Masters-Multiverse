Class {
	#name : #WikitextMixedContentSplitter,
	#superclass : #Object,
	#instVars : [
		'multipleTemplateContentToSplit'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - preconditions' }
WikitextMixedContentSplitter class >> assertNotEmpty: aMultipleTemplateContentToSplit [

	aMultipleTemplateContentToSplit
		ifEmpty: [ ParsingFailed signal: #'A collection of wikitext templates to split was expected' ]
]

{ #category : #'instance creation' }
WikitextMixedContentSplitter class >> splitting: aMultipleTemplateContentToSplit [

	self assertNotEmpty: aMultipleTemplateContentToSplit.
	^ self new initializeSplitting: aMultipleTemplateContentToSplit
]

{ #category : #'private - parsing' }
WikitextMixedContentSplitter >> close: aWikitextTemplateToParse [

	^ '<1s>}}' expandMacrosWith: aWikitextTemplateToParse
]

{ #category : #initialization }
WikitextMixedContentSplitter >> initializeSplitting: aMultipleTemplateContentToSplit [

	multipleTemplateContentToSplit := aMultipleTemplateContentToSplit
]

{ #category : #splitting }
WikitextMixedContentSplitter >> split [

	| trimmedTemplateToParse |

	^ ( multipleTemplateContentToSplit substrings: '}}' )
		collect: [ :splittedTemplateToParse | 
			trimmedTemplateToParse := self trimBrTagsAndWhiteSpacesIn: splittedTemplateToParse.
			( trimmedTemplateToParse beginsWith: '{{' )
				then: [ self close: trimmedTemplateToParse ]
				otherwise: [ trimmedTemplateToParse ]
			]
]

{ #category : #'private - parsing' }
WikitextMixedContentSplitter >> trimBrTagsAndWhiteSpacesIn: aNotClosedWikitextTemplateToParse [

	^ ( aNotClosedWikitextTemplateToParse trimBoth withoutPrefix: '<br>' ) trimLeft
]
