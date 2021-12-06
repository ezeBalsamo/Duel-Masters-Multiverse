Class {
	#name : #ChangeCurrentStepRequestExecutionAssertion,
	#superclass : #RequestExecutionAssertion,
	#category : #'DM-Match-Model'
}

{ #category : #'private - testing' }
ChangeCurrentStepRequestExecutionAssertion class >> canHandle: aRequest [

	^ aRequest isA: ChangeCurrentStepRequest
]
