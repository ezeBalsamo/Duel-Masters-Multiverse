Extension { #name : #Collection }

{ #category : #'*DM-Tools' }
Collection >> hasAnEquivalent: anElementToCompare comparingWith: aDyadicBlock [

	^ self
		anySatisfy: [ :aComparerElement | aDyadicBlock value: aComparerElement value: anElementToCompare ]
]
