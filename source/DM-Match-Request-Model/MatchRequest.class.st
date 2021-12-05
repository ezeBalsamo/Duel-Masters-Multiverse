Class {
	#name : #MatchRequest,
	#superclass : #Object,
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
MatchRequest class >> actionDescription [

	self subclassResponsibility
]

{ #category : #accessing }
MatchRequest >> actionDescription [

	^ self class actionDescription
]

{ #category : #testing }
MatchRequest >> isAllowedIn: aStep [

	^ aStep allowsActionDescribedAs: self actionDescription
]
