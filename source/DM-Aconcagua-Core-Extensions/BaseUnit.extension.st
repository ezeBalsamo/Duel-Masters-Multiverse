Extension { #name : #BaseUnit }

{ #category : #'*DM-Aconcagua-Core-Extensions' }
BaseUnit >> = anObject [

	^ self == anObject or: [ self isEquivalentTo: anObject ]
]

{ #category : #'*DM-Aconcagua-Core-Extensions' }
BaseUnit >> isEquivalentTo: aPotentialBaseUnit [

	^ self nameForOne = aPotentialBaseUnit nameForOne
		and: [ self nameForMany = aPotentialBaseUnit nameForMany and: [ self sign = aPotentialBaseUnit sign ] ]
]
