Class {
	#name : #TestAsserterDuelMastersExtensionsTest,
	#superclass : #TestCase,
	#category : #'DM-SUnit-Tests'
}

{ #category : #'private - printing' }
TestAsserterDuelMastersExtensionsTest >> additionsMessageTextFor: anAdditionalElementCollection on: aStream [

	aStream
		nextPutAll: 'additions : ';
		nextPutAll: ( self formatted: anAdditionalElementCollection );
		cr
]

{ #category : #'private - accessing' }
TestAsserterDuelMastersExtensionsTest >> baseErrorMessageText [

	^ 'Given Collections do not match!'
]

{ #category : #'private - printing' }
TestAsserterDuelMastersExtensionsTest >> baseErrorMessageTextOn: aStream [

	aStream
		nextPutAll: self baseErrorMessageText;
		cr
]

{ #category : #'private - accessing' }
TestAsserterDuelMastersExtensionsTest >> dyadicBlockComparingWith: aSelector [

	^ [ :anElement :anotherElement | anElement perform: aSelector with: anotherElement ]
]

{ #category : #'private - formatting' }
TestAsserterDuelMastersExtensionsTest >> formatted: aCollection [

	^ ( CollectionFormatter separatingWith: ',' ) format: aCollection
]

{ #category : #'private - accessing' }
TestAsserterDuelMastersExtensionsTest >> messageTextWhenAdditionalElementsAre: anAdditionalElementCollection [

	^ String
		streamContents: [ :aStream | 
			self baseErrorMessageTextOn: aStream.
			self additionsMessageTextFor: anAdditionalElementCollection on: aStream
			]
]

{ #category : #'private - accessing' }
TestAsserterDuelMastersExtensionsTest >> messageTextWhenAdditionalElementsAre: anAdditionalElementCollection
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
TestAsserterDuelMastersExtensionsTest >> messageTextWhenMissingElementsAre: aMissingElementCollection [

	^ String
		streamContents: [ :aStream | 
			self baseErrorMessageTextOn: aStream.
			self missingsMessageTextFor: aMissingElementCollection on: aStream
			]
]

{ #category : #'private - printing' }
TestAsserterDuelMastersExtensionsTest >> missingsMessageTextFor: anAdditionalElementCollection on: aStream [

	aStream
		nextPutAll: 'missing: ';
		nextPutAll: ( self formatted: anAdditionalElementCollection );
		cr
]

{ #category : #tests }
TestAsserterDuelMastersExtensionsTest >> test01AssertHasEquivalentElementsComparingWithMessageForEquivalentCollections [

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
TestAsserterDuelMastersExtensionsTest >> test02AssertHasEquivalentElementsComparingWithMessageForEquivalentCollectionsSendingAMessage [

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
TestAsserterDuelMastersExtensionsTest >> test03AssertHasEquivalentElementsComparingWithMessageHavingOnlyOneAdditionalElement [

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
TestAsserterDuelMastersExtensionsTest >> test04AssertHasEquivalentElementsComparingWithMessageHavingManyAdditionalElements [

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
TestAsserterDuelMastersExtensionsTest >> test05AssertHasEquivalentElementsComparingWithMessageHavingOnlyOneMissingElement [

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
TestAsserterDuelMastersExtensionsTest >> test06AssertHasEquivalentElementsComparingWithMessageHavingManyMissingElements [

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
TestAsserterDuelMastersExtensionsTest >> test07AssertHasEquivalentElementsComparingWithMessageHavingBothAdditionalAndMissingElements [

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

{ #category : #tests }
TestAsserterDuelMastersExtensionsTest >> test08AssertTheOnlyOneElementInACollectionIsAnElement [

	| asserter |

	asserter := TestAsserter new.

	self shouldnt: [ asserter assertTheOnlyOneIn: #(1) is: 1 ] raise: TestFailure
]

{ #category : #tests }
TestAsserterDuelMastersExtensionsTest >> test09AssertAllTestsFromATestCaseIsTheTestCaseItself [

	| testCase |

	testCase := TestCase new.

	self assertTheOnlyOneIn: testCase allTests is: testCase
]

{ #category : #tests }
TestAsserterDuelMastersExtensionsTest >> test10AssertAllTestsFromANewTestSuiteIsEmpty [

	| testSuite |

	testSuite := TestSuite named: 'The Test Suite'.

	self assert: testSuite allTests isEmpty
]

{ #category : #tests }
TestAsserterDuelMastersExtensionsTest >> test11AssertAllTestsFromATestSuiteWithATestCaseIsTheTestCase [

	| testCase testSuite |

	testCase := TestCase new.
	testSuite := TestSuite named: 'The Test Suite'.
	testSuite addTest: testCase.

	self assertTheOnlyOneIn: testSuite allTests is: testCase
]
