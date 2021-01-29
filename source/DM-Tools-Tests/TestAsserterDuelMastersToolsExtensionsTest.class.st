Class {
	#name : #TestAsserterDuelMastersToolsExtensionsTest,
	#superclass : #TestCase,
	#category : #'DM-Tools-Tests'
}

{ #category : #'private - printing' }
TestAsserterDuelMastersToolsExtensionsTest >> additionsMessageTextFor: anAdditionalElementCollection on: aStream [

	aStream
		nextPutAll: 'additions : ';
		nextPutAll: ( self formatted: anAdditionalElementCollection );
		cr
]

{ #category : #'private - accessing' }
TestAsserterDuelMastersToolsExtensionsTest >> baseErrorMessageText [

	^ 'Given Collections do not match!'
]

{ #category : #'private - printing' }
TestAsserterDuelMastersToolsExtensionsTest >> baseErrorMessageTextOn: aStream [

	aStream
		nextPutAll: self baseErrorMessageText;
		cr
]

{ #category : #'private - accessing' }
TestAsserterDuelMastersToolsExtensionsTest >> dyadicBlockComparingWith: aSelector [

	^ [ :anElement :anotherElement | anElement perform: aSelector with: anotherElement ]
]

{ #category : #'private - formatting' }
TestAsserterDuelMastersToolsExtensionsTest >> formatted: aCollection [

	^ ( CollectionFormatter separatingWith: ',' ) format: aCollection
]

{ #category : #'private - accessing' }
TestAsserterDuelMastersToolsExtensionsTest >> messageTextWhenAdditionalElementsAre: anAdditionalElementCollection [

	^ String
		streamContents: [ :aStream | 
			self baseErrorMessageTextOn: aStream.
			self additionsMessageTextFor: anAdditionalElementCollection on: aStream
			]
]

{ #category : #'private - accessing' }
TestAsserterDuelMastersToolsExtensionsTest >> messageTextWhenAdditionalElementsAre: anAdditionalElementCollection
	andMissingElementsAre: aMissingElementCollection [


	^ String
		streamContents: [ :aStream | 
			self
				baseErrorMessageTextOn: aStream;
				additionsMessageTextFor: anAdditionalElementCollection on: aStream;
				missingsMessageTextFor: aMissingElementCollection on: aStream
			]
]

{ #category : #'private - accessing' }
TestAsserterDuelMastersToolsExtensionsTest >> messageTextWhenMissingElementsAre: aMissingElementCollection [

	^ String
		streamContents: [ :aStream | 
			self baseErrorMessageTextOn: aStream.
			self missingsMessageTextFor: aMissingElementCollection on: aStream
			]
]

{ #category : #'private - printing' }
TestAsserterDuelMastersToolsExtensionsTest >> missingsMessageTextFor: anAdditionalElementCollection on: aStream [

	aStream
		nextPutAll: 'missing: ';
		nextPutAll: ( self formatted: anAdditionalElementCollection );
		cr
]

{ #category : #tests }
TestAsserterDuelMastersToolsExtensionsTest >> test01AssertHasEquivalentElementsComparingWithMessageForEquivalentCollections [

	| asserter |

	asserter := TestAsserter new.

	self
		shouldnt: [ asserter
				assert: #(1)
				hasEquivalentElementsThan: #(1)
				comparingWith: ( self dyadicBlockComparingWith: #= )
			]
		raise: TestFailure
]

{ #category : #tests }
TestAsserterDuelMastersToolsExtensionsTest >> test02AssertHasEquivalentElementsComparingWithMessageForEquivalentCollectionsSendingAMessage [

	| asserter |

	asserter := TestAsserter new.

	self
		shouldnt: [ asserter
				assert: #(1)
				hasEquivalentElementsThan: #(1)
				comparingWith: [ :anElement :anotherElement | anElement asString = anotherElement asString ]
			]
		raise: TestFailure
]

{ #category : #tests }
TestAsserterDuelMastersToolsExtensionsTest >> test03AssertHasEquivalentElementsComparingWithMessageHavingOnlyOneAdditionalElement [

	| asserter |

	asserter := TestAsserter new.
	self
		should: [ asserter
				assert: #(1)
				hasEquivalentElementsThan: #()
				comparingWith: ( self dyadicBlockComparingWith: #= )
			]
		raise: TestFailure
		withMessageText: ( self messageTextWhenAdditionalElementsAre: #(1) )
]

{ #category : #tests }
TestAsserterDuelMastersToolsExtensionsTest >> test04AssertHasEquivalentElementsComparingWithMessageHavingManyAdditionalElements [

	| asserter |

	asserter := TestAsserter new.

	self
		should: [ asserter
				assert: #(1 2 3)
				hasEquivalentElementsThan: #(2)
				comparingWith: ( self dyadicBlockComparingWith: #= )
			]
		raise: TestFailure
		withMessageText: ( self messageTextWhenAdditionalElementsAre: #(1 3) )
]

{ #category : #tests }
TestAsserterDuelMastersToolsExtensionsTest >> test05AssertHasEquivalentElementsComparingWithMessageHavingOnlyOneMissingElement [

	| asserter |

	asserter := TestAsserter new.

	self
		should: [ asserter
				assert: #()
				hasEquivalentElementsThan: #(1)
				comparingWith: ( self dyadicBlockComparingWith: #= )
			]
		raise: TestFailure
		withMessageText: ( self messageTextWhenMissingElementsAre: #(1) )
]

{ #category : #tests }
TestAsserterDuelMastersToolsExtensionsTest >> test06AssertHasEquivalentElementsComparingWithMessageHavingManyMissingElements [

	| asserter |

	asserter := TestAsserter new.


	self
		should: [ asserter
				assert: #(2)
				hasEquivalentElementsThan: #(1 2 3)
				comparingWith: ( self dyadicBlockComparingWith: #= )
			]
		raise: TestFailure
		withMessageText: ( self messageTextWhenMissingElementsAre: #(1 3) ).
]

{ #category : #tests }
TestAsserterDuelMastersToolsExtensionsTest >> test07AssertHasEquivalentElementsComparingWithMessageHavingBothAdditionalAndMissingElements [

	| asserter |

	asserter := TestAsserter new.

	self
		should: [ asserter
				assert: #(1 2 3)
				hasEquivalentElementsThan: #(2 3 4)
				comparingWith: ( self dyadicBlockComparingWith: #= )
			]
		raise: TestFailure
		withMessageText: ( self messageTextWhenAdditionalElementsAre: #(1) andMissingElementsAre: #(4) )
]
