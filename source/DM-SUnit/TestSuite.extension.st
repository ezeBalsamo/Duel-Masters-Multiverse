Extension { #name : #TestSuite }

{ #category : #'*DM-SUnit' }
TestSuite >> allTests [

	^ self tests flatCollect: #allTests
]
