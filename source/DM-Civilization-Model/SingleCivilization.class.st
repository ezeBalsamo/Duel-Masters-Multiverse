Class {
	#name : #SingleCivilization,
	#superclass : #Civilization,
	#traits : 'PersistentObjectBehaviour',
	#classTraits : 'PersistentObjectBehaviour classTrait',
	#instVars : [
		'name'
	],
	#category : #'DM-Civilization-Model'
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

{ #category : #testing }
SingleCivilization >> hasSameNameThan: aSingleCivilization [

	^ aSingleCivilization isNamed: self name
]

{ #category : #initialization }
SingleCivilization >> initializeNamed: aCivilizationName [

	name := aCivilizationName
]

{ #category : #'private - testing' }
SingleCivilization >> isNamed: aPotentialName [

	^ self name = aPotentialName
]

{ #category : #'private - accessing' }
SingleCivilization >> name [

	^ name
]

{ #category : #printing }
SingleCivilization >> printOn: aStream [

	aStream
		nextPutAll: self name;
		space;
		nextPutAll: 'civilization'
]
