Class {
	#name : #CivilizationManagementSystem,
	#superclass : #SubsystemImplementation,
	#category : #'DM-Civilization-Management-System-Model'
}

{ #category : #installing }
CivilizationManagementSystem >> dependencies [

	^ #()
]

{ #category : #installing }
CivilizationManagementSystem >> implementedInterfaces [

	^ #(#CivilizationManagementSystemInterface)
]

{ #category : #accessing }
CivilizationManagementSystem >> name [

	^'Civilization System'
]
