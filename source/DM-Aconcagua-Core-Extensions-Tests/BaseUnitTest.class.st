"
A BaseUnitTest is a test class for testing the behavior of BaseUnit
"
Class {
	#name : #BaseUnitTest,
	#superclass : #TestCase,
	#category : #'DM-Aconcagua-Core-Extensions-Tests'
}

{ #category : #tests }
BaseUnitTest >> test01BaseUnitEquivalentToAnotherBaseUnit [

	| baseUnit equivalentBaseUnit |

	baseUnit := BaseUnit named: 'unit'.
	equivalentBaseUnit := BaseUnit named: 'unit'.

	self
		assert: baseUnit equals: equivalentBaseUnit;
		assert: ( baseUnit isEquivalentTo: equivalentBaseUnit )
]

{ #category : #tests }
BaseUnitTest >> test02BaseUnitIsNotEquivalentToAnotherBaseUnitWithDifferentNameForOne [

	| baseUnit notEquivalentBaseUnit |

	baseUnit := BaseUnit nameForOne: 'unit' nameForMany: 'units'.
	notEquivalentBaseUnit := BaseUnit nameForOne: 'unit!' nameForMany: 'units'.

	self
		deny: baseUnit equals: notEquivalentBaseUnit;
		deny: ( baseUnit isEquivalentTo: notEquivalentBaseUnit )
]

{ #category : #tests }
BaseUnitTest >> test03BaseUnitIsNotEquivalentToAnotherBaseUnitWithDifferentNameForMany [

	| baseUnit notEquivalentBaseUnit |

	baseUnit := BaseUnit nameForOne: 'unit' nameForMany: 'units'.
	notEquivalentBaseUnit := BaseUnit nameForOne: 'unit' nameForMany: 'units!'.

	self
		deny: baseUnit equals: notEquivalentBaseUnit;
		deny: ( baseUnit isEquivalentTo: notEquivalentBaseUnit )
]

{ #category : #tests }
BaseUnitTest >> test04BaseUnitIsNotEquivalentToAnotherBaseUnitWithDifferentSign [

	| baseUnit notEquivalentBaseUnit |

	baseUnit := BaseUnit nameForOne: 'unit' nameForMany: 'units' sign: 'sign'.
	notEquivalentBaseUnit := BaseUnit nameForOne: 'unit' nameForMany: 'units' sign: 'sign!'.

	self
		deny: baseUnit equals: notEquivalentBaseUnit;
		deny: ( baseUnit isEquivalentTo: notEquivalentBaseUnit )
]
