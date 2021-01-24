"
A CivilizationTest is a test class for testing the behavior of Civilization
"
Class {
	#name : #SingleCivilizationTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Card-Model-Tests'
}

{ #category : #tests }
SingleCivilizationTest >> test01InstanceCreation [

	| fireCivilizationTypeName waterCivilizationTypeName civilization |

	fireCivilizationTypeName := 'Fire'.
	waterCivilizationTypeName := 'Water'.

	civilization := SingleCivilization named: fireCivilizationTypeName.
	self
		assert: ( civilization isNamed: fireCivilizationTypeName );
		deny: ( civilization isNamed: waterCivilizationTypeName )
]

{ #category : #tests }
SingleCivilizationTest >> test02PrintString [

	| civilization |

	civilization := SingleCivilization named: 'Nature'.
	self assert: civilization printString equals: 'Nature civilization'
]
