Extension { #name : #TestAsserter }

{ #category : #'*DM-SUnit' }
TestAsserter >> assert: anActualCollection hasEquivalentElementsThan: anExpectedCollection comparingWith: aDyadicBlock [

	| additionalElements missingElements collectionFormatter |

	additionalElements := anActualCollection
		reject: [ :anElement | anExpectedCollection hasAnEquivalent: anElement comparingWith: aDyadicBlock ].

	missingElements := anExpectedCollection
		reject: [ :anotherElement | anActualCollection hasAnEquivalent: anotherElement comparingWith: aDyadicBlock ].

	collectionFormatter := CollectionFormatter separatingWith: ','.

	self
		assert: ( additionalElements isEmpty and: [ missingElements isEmpty ] )
		description:
			( String
				streamContents: [ :stream | 
					stream
						nextPutAll: 'Given Collections do not match!';
						cr.
					additionalElements
						ifNotEmpty: [ stream
								nextPutAll: 'additions : ';
								nextPutAll: ( collectionFormatter format: additionalElements );
								cr
							].
					missingElements
						ifNotEmpty: [ stream
								nextPutAll: 'missing: ';
								nextPutAll: ( collectionFormatter format: missingElements );
								cr
							]
					] )
]

{ #category : #'*DM-SUnit' }
TestAsserter >> assertTheOnlyOneIn: aCollection is: aPotentialElement [

	self
		withTheOnlyOneIn: aCollection
		do: [ :anElement | self assert: aPotentialElement equals: anElement ]
]

{ #category : #'*DM-SUnit' }
TestAsserter >> theOnlyOneIn: aCollection [

	| element |

	self withTheOnlyOneIn: aCollection do: [ :foundElement | element := foundElement ].

	^ element
]
