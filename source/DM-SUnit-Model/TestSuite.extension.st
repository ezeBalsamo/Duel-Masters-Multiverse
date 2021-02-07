Extension { #name : #TestSuite }

{ #category : #'*DM-SUnit-Model' }
TestSuite >> allTests [

	^ self tests flatCollect: #allTests
]
