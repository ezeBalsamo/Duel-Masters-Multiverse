Class {
	#name : #RequestExecutionAssertion,
	#superclass : #Object,
	#instVars : [
		'request',
		'turnContext',
		'player'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'private - testing' }
RequestExecutionAssertion class >> canHandle: aRequest [

	self subclassResponsibility
]

{ #category : #'instance creation' }
RequestExecutionAssertion class >> for: aRequest requestedBy: aPlayer workingWith: aTurnContext [

	^ ( SuitableClassFinder findDirectSubclassOf: self suitableFor: aRequest ) value new 
		  initializeFor: aRequest
		  requestedBy: aPlayer
		  workingWith: aTurnContext
]

{ #category : #asserting }
RequestExecutionAssertion >> assert [

	self
		assertRequestingPlayerIsTurnPlayer;
		assertRequestIsAllowedInCurrentStep
]

{ #category : #'private - asserting' }
RequestExecutionAssertion >> assertRequestIsAllowedInCurrentStep [

	| currentStep |

	currentStep := turnContext currentStep.

	[ 
	IllegalPlay from: player
		because:
		( 'You can''t <1s> in the <2p>.' expandMacrosWith: request actionDescription with: currentStep )
	] unless: ( request isAllowedIn: currentStep )
]

{ #category : #'private - asserting' }
RequestExecutionAssertion >> assertRequestingPlayerIsTurnPlayer [

	[ 
	IllegalPlay from: player
		because:
		( 'You can''t <1s> on your opponent''s turn.' expandMacrosWith: request actionDescription )
	] unless: turnContext currentPlayer = player
]

{ #category : #initialization }
RequestExecutionAssertion >> initializeFor: aRequest requestedBy: aPlayer workingWith: aTurnContext [

	request := aRequest.
	player := aPlayer.
	turnContext := aTurnContext
]
