Class {
	#name : #MultipleCivilization,
	#superclass : #Object,
	#instVars : [
		'civilizations'
	],
	#category : #'Duel-Masters-Card-Model'
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

{ #category : #testing }
MultipleCivilization >> includesCivilization: aPotentialCivilization [

	^ civilizations anySatisfy: [ :civilization | civilization isEquivalentTo: aPotentialCivilization ]
]

{ #category : #initialization }
MultipleCivilization >> initializeConformedByAll: aCivilizationCollection [

	civilizations := aCivilizationCollection
]
