Class {
	#name : #WikitextTemplateParser,
	#superclass : #Object,
	#instVars : [
		'wikitextTemplateToParse'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextTemplateParser class >> canHandle: aWikitextTemplateToParse [

	self subclassResponsibility
]

{ #category : #'private - testing' }
WikitextTemplateParser class >> hasArguments: aWikitextTemplateToParse [

	^ aWikitextTemplateToParse includesSubstring: '|'
]

{ #category : #'instance creation' }
WikitextTemplateParser class >> toParse: aWikitextTemplateToParse [

	^ ( SuitableClassFinder findDirectSubclassOf: self suitableFor: aWikitextTemplateToParse ) value
		new initializeToParse: aWikitextTemplateToParse
]

{ #category : #initialization }
WikitextTemplateParser >> initializeToParse: aWikitextTemplateToParse [

	wikitextTemplateToParse := aWikitextTemplateToParse
]

{ #category : #parsing }
WikitextTemplateParser >> parse [

	self subclassResponsibility
]
