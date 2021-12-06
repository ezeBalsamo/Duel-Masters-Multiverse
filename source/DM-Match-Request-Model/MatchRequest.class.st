Class {
	#name : #MatchRequest,
	#superclass : #Object,
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
MatchRequest class >> actionDescription [

	^ PlayerActionDescriptions summonCreature
]

{ #category : #accessing }
MatchRequest >> actionDescription [

	^ self class actionDescription
]

{ #category : #executing }
MatchRequest >> executeOn: aMatch [

	self subclassResponsibility
]

{ #category : #testing }
MatchRequest >> isAllowedIn: aStep [

	^ aStep allowsActionDescribedAs: self actionDescription
]
