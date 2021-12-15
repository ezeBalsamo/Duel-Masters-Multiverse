Class {
	#name : #DMRequest,
	#superclass : #Object,
	#category : #'DM-Request-Model'
}

{ #category : #accessing }
DMRequest class >> actionDescription [

	self subclassResponsibility
]

{ #category : #accessing }
DMRequest >> actionDescription [

	^ self class actionDescription
]

{ #category : #executing }
DMRequest >> executeOn: anObject [

	self subclassResponsibility
]
