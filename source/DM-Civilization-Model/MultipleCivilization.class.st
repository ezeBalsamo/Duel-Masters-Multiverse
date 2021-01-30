Class {
	#name : #MultipleCivilization,
	#superclass : #Civilization,
	#instVars : [
		'civilizations'
	],
	#category : #'DM-Civilization-Model'
}

{ #category : #'private - preconditions' }
MultipleCivilization class >> assertHasEnoughCivilizations: aCivilizationCollection [

	AssertionChecker
		enforce: [ aCivilizationCollection size > 1 ]
		because: 'A Multiple Civilization must be conformed by more than one civilization.'
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
MultipleCivilization class >> conformedBy: aCivilization and: anotherCivilization [

	^ self conformedByAll: ( Array with: aCivilization with: anotherCivilization )
]

{ #category : #'instance creation' }
MultipleCivilization class >> conformedByAll: aCivilizationCollection [

	self assertHasEnoughCivilizations: aCivilizationCollection.
	^ self new initializeConformedByAll: aCivilizationCollection
]

{ #category : #initialization }
MultipleCivilization >> initializeConformedByAll: aCivilizationCollection [

	civilizations := aCivilizationCollection
]

{ #category : #testing }
MultipleCivilization >> isNamed: aPotentialName [

	^ civilizations anySatisfy: [ :singleCivilization | singleCivilization isNamed: aPotentialName ]
]
