Class {
	#name : #SingleCivilization,
	#superclass : #Civilization,
	#instVars : [
		'name'
	],
	#category : #'Duel-Masters-Card-Model'
}

{ #category : #'instance creation' }
SingleCivilization class >> named: aCivilizationName [

	^ self new initializeNamed: aCivilizationName
]

{ #category : #initialization }
SingleCivilization >> initializeNamed: aCivilizationName [

	name := aCivilizationName
]

{ #category : #'private - testing' }
SingleCivilization >> isNamed: aPotentialName [

	^ name = aPotentialName
]

{ #category : #printing }
SingleCivilization >> printOn: aStream [

	aStream
		nextPutAll: name;
		space;
		nextPutAll: 'civilization'
]
