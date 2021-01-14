"
A MultipleCivilizationTest is a test class for testing the behavior of MultipleCivilization
"
Class {
	#name : #MultipleCivilizationTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Card-Model-Tests'
}

{ #category : #tests }
MultipleCivilizationTest >> test01MultipleCivilizationCantHaveZeroCivilizations [

	self
		should: [ MultipleCivilization conformedByAll: #() ]
		raise: InstanceCreationFailed
		withMessageText: 'A Multiple Civilization must be conformed by more than one civilization.'.
]

{ #category : #tests }
MultipleCivilizationTest >> test02MultipleCivilizationCantHaveOneCivilization [

	self
		should: [ MultipleCivilization conformedByAll: ( Array with: Civilization fire ) ]
		raise: InstanceCreationFailed
		withMessageText: 'A Multiple Civilization must be conformed by more than one civilization.'
]

{ #category : #tests }
MultipleCivilizationTest >> test03MultipleCivilizationConformedByTwoCivilizations [

	| fireCivilization waterCivilization multipleCivilization |

	fireCivilization := Civilization fire.
	waterCivilization := Civilization water.

	multipleCivilization := MultipleCivilization conformedBy: fireCivilization and: waterCivilization.

	self
		assert: ( multipleCivilization includesCivilization: fireCivilization );
		assert: ( multipleCivilization includesCivilization: waterCivilization );
		deny: ( multipleCivilization includesCivilization: Civilization nature )
]
