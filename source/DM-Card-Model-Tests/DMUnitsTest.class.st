"
A DMUnitsTest is a test class for testing the behavior of DMUnits
"
Class {
	#name : #DMUnitsTest,
	#superclass : #TestCase,
	#category : #'DM-Card-Model-Tests'
}

{ #category : #tests }
DMUnitsTest >> test01UnitsAreInitializedAutomatically [

	| mana power |

	mana := DMUnits mana.
	power := DMUnits power.

	self
		assert: mana isNotNil;
		assert: power isNotNil
]

{ #category : #tests }
DMUnitsTest >> test02UnitsAreInstantiatedOnlyOnce [

	DMUnits initialize.

	self
		assert: DMUnits mana identicalTo: DMUnits mana;
		assert: DMUnits power identicalTo: DMUnits power
]
