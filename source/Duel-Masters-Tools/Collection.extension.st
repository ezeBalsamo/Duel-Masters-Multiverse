Extension { #name : #Collection }

{ #category : #'*Duel-Masters-Tools' }
Collection >> hasAnEquivalent: anElementToCompare comparingWith: aDyadicBlock [

	^ self
		anySatisfy: [ :aComparerElement | aDyadicBlock value: aComparerElement value: anElementToCompare ]
]
