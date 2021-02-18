Extension { #name : #Collection }

{ #category : #'*DM-Collections-Abstract-Base-Extensions' }
Collection >> hasAnEquivalent: anElementToCompare comparingWith: aDyadicBlock [

	^ self
		anySatisfy: [ :aComparerElement | aDyadicBlock value: aComparerElement value: anElementToCompare ]
]
