Class {
	#name : #GenericRace,
	#superclass : #Race,
	#instVars : [
		'typeName',
		'raceParents'
	],
	#category : #'Duel-Masters-Card-Model'
}

{ #category : #'private - preconditions' }
GenericRace class >> assertNotEmpty: aPotentiaTypeName [

	AssertionChecker
		enforce: [ aPotentiaTypeName notEmpty ]
		because: 'A race must have a type name.'
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
GenericRace class >> ofTypeNamed: aTypeName [

	^ self ofTypeNamed: aTypeName categorizedByAll: #()
]

{ #category : #'instance creation' }
GenericRace class >> ofTypeNamed: aTypeName categorizedBy: aRaceParent [

	^ self ofTypeNamed: aTypeName categorizedByAll: ( Array with: aRaceParent )
]

{ #category : #'instance creation' }
GenericRace class >> ofTypeNamed: aTypeName categorizedByAll: aRaceParentCollection [

	self assertNotEmpty: aTypeName.

	^ self new initializeOfTypeNamed: aTypeName categorizedByAll: aRaceParentCollection
]

{ #category : #initialization }
GenericRace >> initializeOfTypeNamed: aTypeName categorizedByAll: aRaceParentCollection [

	typeName := aTypeName.
	raceParents := aRaceParentCollection
]

{ #category : #'private - testing' }
GenericRace >> isARaceParentOfTypeNamed: aPotentialTypeName [

	^ raceParents anySatisfy: [ :race | race isOfTypeNamed: aPotentialTypeName ]
]

{ #category : #testing }
GenericRace >> isGeneric [

	^ true
]

{ #category : #testing }
GenericRace >> isOfTypeNamed: aPotentialTypeName [

	^ typeName = aPotentialTypeName or: [ self isARaceParentOfTypeNamed: aPotentialTypeName ]
]
