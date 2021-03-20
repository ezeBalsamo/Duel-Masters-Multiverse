Extension { #name : #TestCase }

{ #category : #'*DM-SUnit' }
TestCase >> allTests [

	^ Array with: self
]

{ #category : #'*DM-SUnit' }
TestCase class >> emptySuite [

	^ self suiteClass named: self name asString
]
