Class {
	#name : #CardManagementSystem,
	#superclass : #SubsystemImplementation,
	#category : #'DM-Card-Management-System-Model'
}

{ #category : #installing }
CardManagementSystem >> dependencies [

	^ #(#CivilizationManagementSystemInterface #RaceManagementSystemInterface)
]

{ #category : #installing }
CardManagementSystem >> implementedInterfaces [

	^ #(#CardManagementSystemInterface)
]

{ #category : #accessing }
CardManagementSystem >> name [

	^ 'Card System'
]
