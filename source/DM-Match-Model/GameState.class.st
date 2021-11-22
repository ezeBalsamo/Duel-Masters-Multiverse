Class {
	#name : #GameState,
	#superclass : #Object,
	#category : #'DM-Match-Model'
}

{ #category : #accessing }
GameState >> hasEnded [

	self subclassResponsibility
]

{ #category : #accessing }
GameState >> winner [

	self subclassResponsibility
]
