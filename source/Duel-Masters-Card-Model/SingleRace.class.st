Class {
	#name : #SingleRace,
	#superclass : #Race,
	#instVars : [
		'typeName'
	],
	#category : #'Duel-Masters-Card-Model'
}

{ #category : #'instance creation' }
SingleRace class >> ofTypeNamed: aTypeName [

	^ self new initializeOfTypeNamed: aTypeName
]

{ #category : #initialization }
SingleRace >> initializeOfTypeNamed: aTypeName [

	typeName := aTypeName
]

{ #category : #testing }
SingleRace >> isOfTypeNamed: aPotentialTypeName [

	^ typeName = aPotentialTypeName
]
