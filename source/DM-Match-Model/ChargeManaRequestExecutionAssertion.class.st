Class {
	#name : #ChargeManaRequestExecutionAssertion,
	#superclass : #RequestExecutionAssertion,
	#category : #'DM-Match-Model'
}

{ #category : #'private - testing' }
ChargeManaRequestExecutionAssertion class >> canHandle: aRequest [

	^ aRequest isA: ChargeManaRequest
]

{ #category : #asserting }
ChargeManaRequestExecutionAssertion >> assert [

	super assert.
	[ IllegalPlay from: player because: 'Mana can only be charged once per turn.' ] unless:
		turnContext canManaBeCharged
]
