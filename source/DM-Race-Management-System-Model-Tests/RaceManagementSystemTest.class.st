"
A RaceSystemTest is a test class for testing the behavior of RaceSystem
"
Class {
	#name : #RaceManagementSystemTest,
	#superclass : #TestCase,
	#category : #'DM-Race-Management-System-Model-Tests'
}

{ #category : #tests }
RaceManagementSystemTest >> test01Name [

	| raceSystem |

	raceSystem := RaceManagementSystem new.

	self assert: raceSystem name equals: 'Race Management System'
]

{ #category : #tests }
RaceManagementSystemTest >> test02RaceSystemHasNoDependencies [

	| raceSystem |

	raceSystem := RaceManagementSystem new.

	self assert: raceSystem dependencies isEmpty
]

{ #category : #tests }
RaceManagementSystemTest >> test03RaceSystemOnlyImplementsRaceSystemInterface [

	| raceSystem |

	raceSystem := RaceManagementSystem new.

	self assertCollection: raceSystem implementedInterfaces equals: #(#RaceManagementSystemInterface)
]
