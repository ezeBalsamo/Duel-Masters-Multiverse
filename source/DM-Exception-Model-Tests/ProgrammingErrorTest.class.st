"
A ProgrammingErrorTest is a test class for testing the behavior of ProgrammingError
"
Class {
	#name : #ProgrammingErrorTest,
	#superclass : #TestCase,
	#category : #'DM-Exception-Model-Tests'
}

{ #category : #tests }
ProgrammingErrorTest >> test01Signaling [

	| errorDescription |

	errorDescription := 'Oh no! An error happened!'.

	self
		should: [ ProgrammingError signal: errorDescription ]
		raise: ProgrammingError
		withMessageText: errorDescription
]
