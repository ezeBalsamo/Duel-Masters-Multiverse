Class {
	#name : #SingleRace,
	#superclass : #Race,
	#instVars : [
		'typeName',
		'raceParents'
	],
	#category : #'DM-Race-Model'
}

{ #category : #'private - preconditions' }
SingleRace class >> assertNotEmpty: aPotentiaTypeName [

	AssertionChecker
		enforce: [ aPotentiaTypeName notEmpty ]
		because: 'A race must have a type name.'
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
SingleRace class >> ofTypeNamed: aTypeName [

	^ self ofTypeNamed: aTypeName categorizedByAll: #()
]

{ #category : #'instance creation' }
SingleRace class >> ofTypeNamed: aTypeName categorizedBy: aRaceParent [

	^ self ofTypeNamed: aTypeName categorizedByAll: ( Array with: aRaceParent )
]

{ #category : #'instance creation' }
SingleRace class >> ofTypeNamed: aTypeName categorizedByAll: aRaceParentCollection [

	self assertNotEmpty: aTypeName.

	^ self new initializeOfTypeNamed: aTypeName categorizedByAll: aRaceParentCollection
]

{ #category : #initialization }
SingleRace >> initializeOfTypeNamed: aTypeName categorizedByAll: aRaceParentCollection [

	typeName := aTypeName.
	raceParents := aRaceParentCollection
]

{ #category : #'private - testing' }
SingleRace >> isARaceParentOfTypeNamed: aPotentialTypeName [

	^ raceParents anySatisfy: [ :race | race isOfTypeNamed: aPotentialTypeName ]
]

{ #category : #testing }
SingleRace >> isGeneric [

	^ false
]

{ #category : #testing }
SingleRace >> isOfTypeNamed: aPotentialTypeName [

	^ typeName = aPotentialTypeName or: [ self isARaceParentOfTypeNamed: aPotentialTypeName ]
]
