Class {
	#name : #WikitextTemplateParser,
	#superclass : #Object,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
WikitextTemplateParser class >> canHandle: aWikitextTemplateToParse [

	self subclassResponsibility
]

{ #category : #'instance creation' }
WikitextTemplateParser class >> toParse: aWikitextTemplateToParse [

	^ ( SuitableClassFinder findDirectSubclassOf: self suitableFor: aWikitextTemplateToParse ) value
		new initializeToParse: aWikitextTemplateToParse
]

{ #category : #initialization }
WikitextTemplateParser >> initializeToParse: aWikitextTemplateToParse [

	self subclassResponsibility
]

{ #category : #parsing }
WikitextTemplateParser >> parse [

	self subclassResponsibility
]
