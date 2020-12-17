Class {
	#name : #WikitextTemplate,
	#superclass : #Object,
	#instVars : [
		'wikitextArguments',
		'name'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'instance creation' }
WikitextTemplate class >> named: aTemplateName withArgument: aWikitextArgument [

	^ self named: aTemplateName withArguments: {aWikitextArgument}
]

{ #category : #'instance creation' }
WikitextTemplate class >> named: aTemplateName withArguments: aWikitextArgumentCollection [

	^ self new initializeNamed: aTemplateName withArguments: aWikitextArgumentCollection
]

{ #category : #testing }
WikitextTemplate >> hasArgumentNamed: aPotentialName withContent: aPotentialContent [

	^ wikitextArguments
		detect: [ :aWikitextArgument | aWikitextArgument isNamed: aPotentialName ]
		ifFound: [ :foundWikitextArgument | foundWikitextArgument hasContent: aPotentialContent ]
		ifNone: [ false ]
]

{ #category : #'testing - private' }
WikitextTemplate >> hasEquivalentArgument: aPotentialWikitextArgument [

	^ wikitextArguments
		anySatisfy: [ :aWikitextArgument | aWikitextArgument isEquivalentTo: aPotentialWikitextArgument ]
]

{ #category : #'testing - private' }
WikitextTemplate >> hasEquivalentArguments: aWikitextTemplate [

	^ wikitextArguments
		allSatisfy: [ :aWikitextArgument | aWikitextTemplate hasEquivalentArgument: aWikitextArgument ]
]

{ #category : #initialization }
WikitextTemplate >> initializeNamed: aTemplateName withArguments: aWikitextArgumentCollection [

	name := aTemplateName.
	wikitextArguments := aWikitextArgumentCollection
]

{ #category : #testing }
WikitextTemplate >> isEquivalentTo: aWikitextTemplate [

	^ ( aWikitextTemplate isNamed: name )
		and: [ self hasEquivalentArguments: aWikitextTemplate ]
]

{ #category : #testing }
WikitextTemplate >> isNamed: aPotentialName [

	^ name = aPotentialName
]
