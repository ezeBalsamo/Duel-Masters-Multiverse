Class {
	#name : #SingleCivilization,
	#superclass : #Civilization,
	#instVars : [
		'name'
	],
	#category : #'Duel-Masters-Card-Model'
}

{ #category : #'private - preconditions' }
SingleCivilization class >> assertNotEmpty: aPotentialCivilizationName [

	AssertionChecker
		enforce: [ aPotentialCivilizationName notEmpty ]
		because: 'A civilization must have a name.'
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
SingleCivilization class >> named: aCivilizationName [

	self assertNotEmpty: aCivilizationName.

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
