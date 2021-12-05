Class {
	#name : #TurnStep,
	#superclass : #Object,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
TurnStep >> allowedActions [

	self subclassResponsibility
]

{ #category : #testing }
TurnStep >> allows: aRequest [

	^ self allowedActions includes: aRequest actionDescription
]

{ #category : #printing }
TurnStep >> printOn: aStream [

	^ aStream
		  nextPutAll: self stepName;
		  nextPutAll: ' Step'
]

{ #category : #'private - accessing' }
TurnStep >> stepName [

	self subclassResponsibility
]
