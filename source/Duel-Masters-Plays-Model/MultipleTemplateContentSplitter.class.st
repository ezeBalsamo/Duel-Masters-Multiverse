Class {
	#name : #MultipleTemplateContentSplitter,
	#superclass : #Object,
	#instVars : [
		'multipleTemplateContentToSplit'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - preconditions' }
MultipleTemplateContentSplitter class >> assertNotEmpty: aMultipleTemplateContentToSplit [

	aMultipleTemplateContentToSplit
		ifEmpty: [ ParsingFailed signal: #'A collection of wikitext templates to split was expected' ]
]

{ #category : #'instance creation' }
MultipleTemplateContentSplitter class >> splitting: aMultipleTemplateContentToSplit [

	self assertNotEmpty: aMultipleTemplateContentToSplit.
	^ self new initializeSplitting: aMultipleTemplateContentToSplit
]

{ #category : #'private - parsing' }
MultipleTemplateContentSplitter >> close: aWikitextTemplateToParse [

	^ '<1s>}}' expandMacrosWith: aWikitextTemplateToParse
]

{ #category : #initialization }
MultipleTemplateContentSplitter >> initializeSplitting: aMultipleTemplateContentToSplit [

	multipleTemplateContentToSplit := aMultipleTemplateContentToSplit
]

{ #category : #splitting }
MultipleTemplateContentSplitter >> split [

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
MultipleTemplateContentSplitter >> trimBrTagsAndWhiteSpacesIn: aNotClosedWikitextTemplateToParse [

	^ ( aNotClosedWikitextTemplateToParse trimBoth withoutPrefix: '<br>' ) trimLeft
]
