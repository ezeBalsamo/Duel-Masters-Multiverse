Class {
	#name : #Civilization,
	#superclass : #Object,
	#traits : 'PersistentObjectBehaviour',
	#classTraits : 'PersistentObjectBehaviour classTrait',
	#instVars : [
		'name'
	],
	#category : #'DM-Civilization-Model'
}

{ #category : #'private - preconditions' }
Civilization class >> assertNotEmpty: aPotentialCivilizationName [

	AssertionChecker
		enforce: [ aPotentialCivilizationName notEmpty ]
		because: 'A civilization must have a name.'
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
Civilization class >> named: aCivilizationName [

	self assertNotEmpty: aCivilizationName.

	^ self new initializeNamed: aCivilizationName
]

{ #category : #accessing }
Civilization >> civilizations [

	^ Array with: self
]

{ #category : #testing }
Civilization >> hasSameNameThan: aSingleCivilization [

	^ aSingleCivilization isNamed: self name
]

{ #category : #initialization }
Civilization >> initializeNamed: aCivilizationName [

	name := aCivilizationName
]

{ #category : #testing }
Civilization >> isNamed: aPotentialName [

	^ self name = aPotentialName
]

{ #category : #'private - accessing' }
Civilization >> name [

	^ name
]

{ #category : #printing }
Civilization >> printOn: aStream [

	aStream
		nextPutAll: self name;
		space;
		nextPutAll: 'civilization'
]
