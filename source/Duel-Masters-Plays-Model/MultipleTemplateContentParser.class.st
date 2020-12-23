Class {
	#name : #MultipleTemplateContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
MultipleTemplateContentParser class >> canHandle: aWikitextContentToParse [

	^ self isMultipleTemplateContent: aWikitextContentToParse
]

{ #category : #'private - accessing' }
MultipleTemplateContentParser >> wikitextTemplatesToParse [

	^ ( wikitextContentToParse substrings: '}}' )
		collect: [ :notClosedWikitextTemplateToParse | '<1s>}}' expandMacrosWith: notClosedWikitextTemplateToParse ]
]

{ #category : #'private - accessing' }
MultipleTemplateContentParser >> wikitextTemplatesToParseCollect: aBlockClosure [

	^ self wikitextTemplatesToParse collect: aBlockClosure
]
