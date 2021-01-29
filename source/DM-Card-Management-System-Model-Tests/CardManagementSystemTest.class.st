"
A CardSystemTest is a test class for testing the behavior of CardSystem
"
Class {
	#name : #CardManagementSystemTest,
	#superclass : #TestCase,
	#category : #'DM-Card-Management-System-Model-Tests'
}

{ #category : #tests }
CardManagementSystemTest >> test01Name [

	| cardSystem |

	cardSystem := CardManagementSystem new.

	self assert: cardSystem name equals: 'Card System'
]

{ #category : #tests }
CardManagementSystemTest >> test02CardSystemDependsOfRaceSystemAndCivilizationSystem [

	| cardSystem |

	cardSystem := CardManagementSystem new.

	self
		assertCollection: cardSystem dependencies
		hasSameElements: #(#CivilizationManagementSystemInterface #RaceManagementSystemInterface)
]

{ #category : #tests }
CardManagementSystemTest >> test03CardSystemOnlyImplementsCardSystemInterface [

	| cardSystem |

	cardSystem := CardManagementSystem new.

	self assertCollection: cardSystem implementedInterfaces equals: #(#CardManagementSystemInterface)
]
