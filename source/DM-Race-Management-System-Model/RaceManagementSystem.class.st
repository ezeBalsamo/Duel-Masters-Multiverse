Class {
	#name : #RaceManagementSystem,
	#superclass : #SubsystemImplementation,
	#category : #'DM-Race-Management-System-Model'
}

{ #category : #installing }
RaceManagementSystem >> dependencies [

	^ #()
]

{ #category : #installing }
RaceManagementSystem >> implementedInterfaces [

	^ #(#RaceManagementSystemInterface)
]

{ #category : #accessing }
RaceManagementSystem >> name [

	^ 'Race Management System'
]
