"
A MultipleCivilizationTest is a test class for testing the behavior of MultipleCivilization
"
Class {
	#name : #MultipleCivilizationTest,
	#superclass : #TestCase,
	#category : #'DM-Civilization-Model-Tests'
}

{ #category : #'private - accessing' }
MultipleCivilizationTest >> fireCivilization [

	^ SingleCivilization named: self fireCivilizationName
]

{ #category : #'private - accessing' }
MultipleCivilizationTest >> fireCivilizationName [

	^ 'Fire'
]

{ #category : #'private - accessing' }
MultipleCivilizationTest >> natureCivilizationName [

	^ 'Nature'
]

{ #category : #tests }
MultipleCivilizationTest >> test01MultipleCivilizationCantHaveZeroCivilizations [

	self
		should: [ MultipleCivilization conformedByAll: #() ]
		raise: InstanceCreationFailed
		withMessageText: 'A Multiple Civilization must be conformed by more than one civilization.'
]

{ #category : #tests }
MultipleCivilizationTest >> test02MultipleCivilizationCantHaveOneCivilization [

	self
		should: [ MultipleCivilization conformedByAll: ( Array with: self fireCivilization ) ]
		raise: InstanceCreationFailed
		withMessageText: 'A Multiple Civilization must be conformed by more than one civilization.'
]

{ #category : #tests }
MultipleCivilizationTest >> test03MultipleCivilizationConformedByTwoCivilizations [

	| fireCivilizationName waterCivilizationName natureCivilizationName fireCivilization waterCivilization multipleCivilization |

	fireCivilizationName := self fireCivilizationName.
	waterCivilizationName := self waterCivilizationName.
	natureCivilizationName := self natureCivilizationName.

	fireCivilization := self fireCivilization.
	waterCivilization := self waterCivilization.

	multipleCivilization := MultipleCivilization conformedBy: fireCivilization and: waterCivilization.

	self
		assert: ( multipleCivilization isNamed: fireCivilizationName );
		assert: ( multipleCivilization isNamed: waterCivilizationName );
		deny: ( multipleCivilization isNamed: natureCivilizationName )
]

{ #category : #'private - accessing' }
MultipleCivilizationTest >> waterCivilization [

	^ SingleCivilization named: self waterCivilizationName
]

{ #category : #'private - accessing' }
MultipleCivilizationTest >> waterCivilizationName [

	^ 'Water'
]
