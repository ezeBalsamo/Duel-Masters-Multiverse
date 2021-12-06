Class {
	#name : #DrawCardRequestExecutionAssertion,
	#superclass : #RequestExecutionAssertion,
	#category : #'DM-Match-Model'
}

{ #category : #'private - testing' }
DrawCardRequestExecutionAssertion class >> canHandle: aRequest [

	^ aRequest isA: DrawCardRequest
]

{ #category : #asserting }
DrawCardRequestExecutionAssertion >> assert [

	super assert.
	[ IllegalPlay from: player because: 'Only one card can be drawn per turn.' ] unless:
		turnContext canCardBeDrawn
]
