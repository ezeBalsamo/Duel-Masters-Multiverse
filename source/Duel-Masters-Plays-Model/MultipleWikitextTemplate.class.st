Class {
	#name : #MultipleWikitextTemplate,
	#superclass : #Object,
	#instVars : [
		'wikitextTemplates'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'instance creation' }
MultipleWikitextTemplate class >> conformedByAll: aWikitextTemplateCollection [

	^ self new initializeConformedByAll: aWikitextTemplateCollection
]

{ #category : #'private - testing' }
MultipleWikitextTemplate >> hasEquivalentTemplates: aMultipleWikitextTemplate [

	^ wikitextTemplates
		allSatisfy: [ :wikitextTemplate | aMultipleWikitextTemplate hasWikitextTemplate: wikitextTemplate ]
]

{ #category : #testing }
MultipleWikitextTemplate >> hasWikitextTemplate: aPotentialWikitextTemplate [

	^ wikitextTemplates
		anySatisfy: [ :wikitextTemplate | wikitextTemplate isEquivalentTo: aPotentialWikitextTemplate ]
]

{ #category : #initialization }
MultipleWikitextTemplate >> initializeConformedByAll: aWikitextTemplateCollection [

	wikitextTemplates := aWikitextTemplateCollection
]

{ #category : #testing }
MultipleWikitextTemplate >> isEquivalentTo: aMultipleWikitextTemplate [

	^ ( self hasEquivalentTemplates: aMultipleWikitextTemplate )
		and: [ aMultipleWikitextTemplate hasEquivalentTemplates: self ]
]
