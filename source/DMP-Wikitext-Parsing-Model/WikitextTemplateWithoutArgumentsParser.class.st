Class {
	#name : #WikitextTemplateWithoutArgumentsParser,
	#superclass : #WikitextTemplateParser,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #'private - testing' }
WikitextTemplateWithoutArgumentsParser class >> canHandle: aWikitextTemplateToParse [

	^ ( self hasArguments: aWikitextTemplateToParse ) not
]

{ #category : #parsing }
WikitextTemplateWithoutArgumentsParser >> parse [

	^ WikitextTemplate withoutArgumentsNamed: wikitextTemplateToParse
]
