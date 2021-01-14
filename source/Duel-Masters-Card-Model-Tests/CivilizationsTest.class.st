"
A CivilizationsTest is a test class for testing the behavior of Civilizations
"
Class {
	#name : #CivilizationsTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Card-Model-Tests'
}

{ #category : #tests }
CivilizationsTest >> test01AllCivilizations [

	| allCivilizations expectedCivilizations |

	allCivilizations := Civilizations all.
	expectedCivilizations := Array
		with: Civilization fire
		with: Civilization water
		with: Civilization nature
		with: Civilization light
		with: Civilization darkness.

	self
		assert: allCivilizations
		hasEquivalentElementsThan: expectedCivilizations
		comparingWith: [ :aCivilization :anExpectedCivilization | aCivilization isEquivalentTo: anExpectedCivilization ]
]
