Class {
	#name : #MultipleTemplateContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
MultipleTemplateContentParser class >> canHandle: aWikitextContentToParse [

	^ self isMultipleTemplateContent: aWikitextContentToParse
]

{ #category : #initialization }
MultipleTemplateContentParser >> parse [

	| wikitextTemplates |

	wikitextTemplates := self
		wikitextTemplatesToParseCollect: [ :wikitextTemplateToParse | WikitextParser parse: wikitextTemplateToParse ].

	^ MultipleWikitextTemplate conformedByAll: wikitextTemplates
]

{ #category : #'private - accessing' }
MultipleTemplateContentParser >> wikitextTemplatesToParse [

	^ ( MultipleTemplateContentSplitter splitting: wikitextContentToParse ) split
]

{ #category : #'private - accessing' }
MultipleTemplateContentParser >> wikitextTemplatesToParseCollect: aBlockClosure [

	^ self wikitextTemplatesToParse collect: aBlockClosure
]
