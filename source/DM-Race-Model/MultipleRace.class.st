Class {
	#name : #MultipleRace,
	#superclass : #Race,
	#instVars : [
		'singleRaces'
	],
	#category : #'DM-Race-Model'
}

{ #category : #'private - preconditions' }
MultipleRace class >> assertHasEnoughRaces: aSingleRaceCollection [

	AssertionChecker
		enforce: [ aSingleRaceCollection size > 1 ]
		because: 'A Multiple Race must be conformed by more than one race.'
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
MultipleRace class >> conformedBy: aSingleRace and: anotherSingleRace [

	^ self conformedByAll: ( Array with: aSingleRace with: anotherSingleRace )
]

{ #category : #'instance creation' }
MultipleRace class >> conformedByAll: aSingleRaceCollection [

	self assertHasEnoughRaces: aSingleRaceCollection.
	^ self new initializeConformedByAll: aSingleRaceCollection
]

{ #category : #initialization }
MultipleRace >> initializeConformedByAll: aSingleRaceCollection [

	singleRaces := aSingleRaceCollection
]

{ #category : #initialization }
MultipleRace >> isGeneric [

	^ false
]

{ #category : #testing }
MultipleRace >> isOfTypeNamed: aPotentialTypeName [

	^ singleRaces anySatisfy: [ :aSingleRace | aSingleRace isOfTypeNamed: aPotentialTypeName ]
]
