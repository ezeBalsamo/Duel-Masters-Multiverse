Class {
	#name : #WikitextTemplate,
	#superclass : #Object,
	#instVars : [
		'templateName',
		'wikitextArguments'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #asserting }
WikitextTemplate class >> assertIsNotEmpty: aWikitextArgumentCollection [

	aWikitextArgumentCollection
		ifEmpty: [ InstanceCreationFailed signal: 'The Template must have at least one argument.' ]
]

{ #category : #'instance creation' }
WikitextTemplate class >> named: aTemplateName withArgument: aWikitextArgument [

	^ self named: aTemplateName withArguments: {aWikitextArgument}
]

{ #category : #'instance creation' }
WikitextTemplate class >> named: aTemplateName withArguments: aWikitextArgumentCollection [

	self assertIsNotEmpty: aWikitextArgumentCollection.

	^ self new initializeNamed: aTemplateName withArguments: aWikitextArgumentCollection
]

{ #category : #'accessing-testing' }
WikitextTemplate >> hasArgumentNamed: aPotentialArgumentName withContent: aPotentialArgumentContent [

	^ wikitextArguments
		detect: [ :aWikitextArgument | aWikitextArgument isNamed: aPotentialArgumentName ]
		ifFound: [ :foundWikitextArgument | foundWikitextArgument hasContent: aPotentialArgumentContent ]
		ifNone: [ false ]
]

{ #category : #initialization }
WikitextTemplate >> initializeNamed: aTemplateName withArguments: aWikitextArgumentCollection [

	templateName := aTemplateName.
	wikitextArguments := aWikitextArgumentCollection
]

{ #category : #'accessing-testing' }
WikitextTemplate >> isNamed: aPotentialTemplateName [

	^ templateName = aPotentialTemplateName
]
