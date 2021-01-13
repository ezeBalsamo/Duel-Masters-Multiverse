"
A CivilizationTest is a test class for testing the behavior of Civilization
"
Class {
	#name : #CivilizationTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Card-Model-Tests'
}

{ #category : #tests }
CivilizationTest >> test01InstanceCreation [

	| civilization |

	civilization := Civilization fire.
	self
		assert: ( civilization isEquivalentTo: Civilization fire );
		deny: ( civilization isEquivalentTo: Civilization water )
]

{ #category : #tests }
CivilizationTest >> test02PrintString [

	| civilization |

	civilization := Civilization nature.
	self assert: civilization printString equals: 'Nature civilization'
]
