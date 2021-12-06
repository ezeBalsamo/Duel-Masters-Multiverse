Class {
	#name : #TurnStep,
	#superclass : #Object,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
TurnStep >> allowedActionDescriptions [

	self subclassResponsibility
]

{ #category : #testing }
TurnStep >> allowsActionDescribedAs: anActionDescription [

	^ self allowedActionDescriptions includes: anActionDescription
]

{ #category : #testing }
TurnStep >> allowsExecutionOf: aRequest [

	^ self allowsActionDescribedAs: aRequest actionDescription
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
