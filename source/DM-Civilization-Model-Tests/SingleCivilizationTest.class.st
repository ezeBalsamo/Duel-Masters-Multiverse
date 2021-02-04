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

	| fireCivilizationName waterCivilizationName civilization |

	fireCivilizationName := 'Fire'.
	waterCivilizationName := 'Water'.

	civilization := SingleCivilization named: fireCivilizationName.
	self
		assert: ( civilization isNamed: fireCivilizationName );
		deny: ( civilization isNamed: waterCivilizationName )
]

{ #category : #tests }
SingleCivilizationTest >> test03PrintString [

	| civilization |

	civilization := SingleCivilization named: 'Nature'.
	self assert: civilization printString equals: 'Nature civilization'
]

{ #category : #tests }
SingleCivilizationTest >> test04SingleCivilizationHavingSameNameThanAnotherSingleCivilization [

	| fireCivilizationName civilization anotherCivilization |

	fireCivilizationName := 'Fire'.

	civilization := SingleCivilization named: fireCivilizationName.
	anotherCivilization := SingleCivilization named: fireCivilizationName.

	self assert: ( civilization hasSameNameThan: anotherCivilization )
]

{ #category : #tests }
SingleCivilizationTest >> test05SingleCivilizationHavingDifferentNameThanAnotherSingleCivilization [

	| fireCivilizationName waterCivilizationName civilization anotherCivilization |

	fireCivilizationName := 'Fire'.
	waterCivilizationName := 'Water'.

	civilization := SingleCivilization named: fireCivilizationName.
	anotherCivilization := SingleCivilization named: waterCivilizationName.

	self deny: ( civilization hasSameNameThan: anotherCivilization )
]
