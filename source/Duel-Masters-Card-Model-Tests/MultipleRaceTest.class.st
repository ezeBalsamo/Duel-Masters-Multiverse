"
A MultipleRaceTest is a test class for testing the behavior of MultipleRace
"
Class {
	#name : #MultipleRaceTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Card-Model-Tests'
}

{ #category : #'private - accessing' }
MultipleRaceTest >> alienRace [

	^ SingleRace ofTypeNamed: self alienRaceTypeName
]

{ #category : #'private - accessing' }
MultipleRaceTest >> alienRaceTypeName [

	^ 'Alien'
]

{ #category : #'private - accessing' }
MultipleRaceTest >> arcSeraphimRaceTypeName [

	^ 'Arc Seraphim'
]

{ #category : #'private - accessing' }
MultipleRaceTest >> armorloidRace [

	^ SingleRace ofTypeNamed: self armorloidRaceTypeName
]

{ #category : #'private - accessing' }
MultipleRaceTest >> armorloidRaceTypeName [

	^ 'Armorloid'
]

{ #category : #tests }
MultipleRaceTest >> test01MultipleRaceCantHaveZeroRaces [

	self
		should: [ MultipleRace conformedByAll: #() ]
		raise: InstanceCreationFailed
		withMessageText: 'A Multiple Race must be conformed by more than one race.'
]

{ #category : #tests }
MultipleRaceTest >> test02MultipleRaceCantHaveOneRace [

	self
		should: [ MultipleRace conformedByAll: ( Array with: self alienRace ) ]
		raise: InstanceCreationFailed
		withMessageText: 'A Multiple Race must be conformed by more than one race.'
]

{ #category : #tests }
MultipleRaceTest >> test03MultipleRaceConformedByTwoUncategorizedRaces [

	| alienRaceTypeName armorloidRaceTypeName arcSeraphimRaceTypeName alienRace armorloidRace multipleRace |

	alienRaceTypeName := self alienRaceTypeName.
	armorloidRaceTypeName := self armorloidRaceTypeName.
	arcSeraphimRaceTypeName := self arcSeraphimRaceTypeName.

	alienRace := self alienRace.
	armorloidRace := self armorloidRace.

	multipleRace := MultipleRace conformedBy: alienRace and: armorloidRace.

	self
		assert: ( multipleRace isOfTypeNamed: alienRaceTypeName );
		assert: ( multipleRace isOfTypeNamed: armorloidRaceTypeName );
		deny: ( multipleRace isOfTypeNamed: arcSeraphimRaceTypeName )
]
