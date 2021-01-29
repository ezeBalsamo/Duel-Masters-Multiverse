"
A CivilizationSystemTest is a test class for testing the behavior of CivilizationSystem
"
Class {
	#name : #CivilizationManagementSystemTest,
	#superclass : #TestCase,
	#category : #'DM-Civilization-Management-System-Model-Tests'
}

{ #category : #tests }
CivilizationManagementSystemTest >> test01Name [

	| civilizationSystem |

	civilizationSystem := CivilizationManagementSystem new.

	self assert: civilizationSystem name equals: 'Civilization System'
]

{ #category : #tests }
CivilizationManagementSystemTest >> test02CivilizationSystemHasNoDependencies [

	| civilizationSystem |

	civilizationSystem := CivilizationManagementSystem new.

	self assertEmpty: civilizationSystem dependencies
]

{ #category : #tests }
CivilizationManagementSystemTest >> test03CivilizationSystemOnlyImplementsCivilizationSystemInterface [

	| civilizationSystem |

	civilizationSystem := CivilizationManagementSystem new.

	self
		assertCollection: civilizationSystem implementedInterfaces
		equals: #(#CivilizationManagementSystemInterface)
]
