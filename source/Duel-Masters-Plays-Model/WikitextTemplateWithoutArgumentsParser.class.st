Class {
	#name : #WikitextTemplateWithoutArgumentsParser,
	#superclass : #WikitextTemplateParser,
	#instVars : [
		'templateName'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
WikitextTemplateWithoutArgumentsParser class >> canHandle: aWikitextTemplateToParse [

	^ ( aWikitextTemplateToParse includesSubstring: '|' ) not
]

{ #category : #initialization }
WikitextTemplateWithoutArgumentsParser >> initializeToParse: aWikitextTemplateToParse [

	templateName := aWikitextTemplateToParse
]

{ #category : #parsing }
WikitextTemplateWithoutArgumentsParser >> parse [

	^ WikitextTemplate withoutArgumentsNamed: templateName
]
