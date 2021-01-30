"
A CivilizationTest is a test class for testing the behavior of Civilization
"
Class {
	#name : #SingleCivilizationTest,
	#superclass : #TestCase,
	#category : #'DM-Civilization-Model-Tests'
}

{ #category : #tests }
SingleCivilizationTest >> test01CivilizationNameMustNotBeEmpty [

	self
		should: [ SingleCivilization named: '' ]
		raise: InstanceCreationFailed
		withMessageText: 'A civilization must have a name.'
]

{ #category : #tests }
SingleCivilizationTest >> test02InstanceCreation [

	| fireCivilizationTypeName waterCivilizationTypeName civilization |

	fireCivilizationTypeName := 'Fire'.
	waterCivilizationTypeName := 'Water'.

	civilization := SingleCivilization named: fireCivilizationTypeName.
	self
		assert: ( civilization isNamed: fireCivilizationTypeName );
		deny: ( civilization isNamed: waterCivilizationTypeName )
]

{ #category : #tests }
SingleCivilizationTest >> test03PrintString [

	| civilization |

	civilization := SingleCivilization named: 'Nature'.
	self assert: civilization printString equals: 'Nature civilization'
]
