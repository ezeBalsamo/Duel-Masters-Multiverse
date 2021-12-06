Class {
	#name : #SummonCreatureRequestExecutionAssertion,
	#superclass : #RequestExecutionAssertion,
	#category : #'DM-Match-Model'
}

{ #category : #'private - testing' }
SummonCreatureRequestExecutionAssertion class >> canHandle: aRequest [

	^ aRequest isA: SummonCreatureRequest
]
