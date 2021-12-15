Class {
	#name : #TurnStep,
	#superclass : #Object,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
TurnStep >> allowedActionDescriptions [

	^ OrderedCollection with: PlayerActionDescriptions changeCurrentStep
		  with: PlayerActionDescriptions endTurn
]

{ #category : #testing }
TurnStep >> allowsActionDescribedAs: anActionDescription [

	^ self allowedActionDescriptions includes: anActionDescription
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
