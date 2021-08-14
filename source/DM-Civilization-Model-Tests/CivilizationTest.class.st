"
A CivilizationTest is a test class for testing the behavior of Civilization
"
Class {
	#name : #CivilizationTest,
	#superclass : #TestCase,
	#category : #'DM-Civilization-Model-Tests'
}

{ #category : #'private - accessing' }
CivilizationTest >> fireCivilizationName [

	^ 'Fire'
]

{ #category : #'private - accessing' }
CivilizationTest >> natureCivilizationName [

	^ 'Nature'
]

{ #category : #tests }
CivilizationTest >> test01CivilizationNameMustNotBeEmpty [

	self
		should: [ Civilization named: '' ]
		raise: InstanceCreationFailed
		withMessageText: 'A civilization must have a name.'
]

{ #category : #tests }
CivilizationTest >> test02InstanceCreation [

	| fireCivilizationName waterCivilizationName civilization |

	fireCivilizationName := self fireCivilizationName.
	waterCivilizationName := self waterCivilizationName.

	civilization := Civilization named: fireCivilizationName.
	self
		assert: ( civilization isNamed: fireCivilizationName );
		deny: ( civilization isNamed: waterCivilizationName )
]

{ #category : #tests }
CivilizationTest >> test03PrintString [

	| civilization |

	civilization := Civilization named: self natureCivilizationName.
	self assert: civilization asString equals: 'Nature civilization'
]

{ #category : #tests }
CivilizationTest >> test04CivilizationHavingSameNameThanAnotherCivilization [

	| civilization anotherCivilization |

	civilization := Civilization named: self fireCivilizationName.
	anotherCivilization := Civilization named: self fireCivilizationName.

	self assert: ( civilization hasSameNameThan: anotherCivilization )
]

{ #category : #tests }
CivilizationTest >> test05CivilizationHavingDifferentNameThanAnotherCivilization [

	| civilization anotherCivilization |

	civilization := Civilization named: self fireCivilizationName.
	anotherCivilization := Civilization named: self waterCivilizationName.

	self deny: ( civilization hasSameNameThan: anotherCivilization )
]

{ #category : #tests }
CivilizationTest >> test06Civilizations [

	| singleCivilization |

	singleCivilization := Civilization named: self fireCivilizationName.

	self
		withTheOnlyOneIn: singleCivilization civilizations
		do: [ :aCivilization | self assert: aCivilization equals: singleCivilization ]
]

{ #category : #'private - accessing' }
CivilizationTest >> waterCivilizationName [

	^ 'Water'
]
