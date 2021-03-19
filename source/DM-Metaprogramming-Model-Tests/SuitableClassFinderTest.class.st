"
A SuitableClassFinderTest is a test class for testing the behavior of SuitableClassFinder
"
Class {
	#name : #SuitableClassFinderTest,
	#superclass : #TestCase,
	#instVars : [
		'abstractNumberClass',
		'concreteNumberOneClass',
		'concreteNumberTwoClass',
		'concreteNumberThreeClass',
		'abstractNumbersTwoAndThreeClass',
		'allLeafSubclasses'
	],
	#category : #'DM-Metaprogramming-Model-Tests'
}

{ #category : #'private - accessing' }
SuitableClassFinderTest >> canHandleMessageFor: aCollection [

	^ 'canHandle: aNumber ^<1s> includes: aNumber' expandMacrosWith: aCollection asString
]

{ #category : #'private - accessing' }
SuitableClassFinderTest >> canHandleMessageFor: aCollection with: aDescription [

	^ 'canHandle: aNumber with: aDescription ^(<1s> includes: aNumber) and: [ ''<2s>'' = aDescription]'
		expandMacrosWith: aCollection asString
		with: aDescription asString
]

{ #category : #'private - compiling' }
SuitableClassFinderTest >> compileCanHandleMethodFor: aCollection inMetaclassOf: aClass [

	aClass class compile: ( self canHandleMessageFor: aCollection )
]

{ #category : #'private - compiling' }
SuitableClassFinderTest >> compileCanHandleMethodFor: aCollection with: aDescription inMetaclassOf: aClass [

	aClass class compile: ( self canHandleMessageFor: aCollection with: aDescription )
]

{ #category : #'private - accessing' }
SuitableClassFinderTest >> createSubclassOf: aSuperclass named: aClassName [

	^ aSuperclass
		subclass: aClassName
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		package: self class category
]

{ #category : #running }
SuitableClassFinderTest >> setUp [

	super setUp.

	abstractNumberClass := self createSubclassOf: Object named: 'AbstractNumber'.
	concreteNumberOneClass := self createSubclassOf: abstractNumberClass named: 'ConcreteNumberOne'.
	abstractNumbersTwoAndThreeClass := self
		createSubclassOf: abstractNumberClass
		named: 'AbstractNumbersTwoAndThree'.
	concreteNumberTwoClass := self
		createSubclassOf: abstractNumbersTwoAndThreeClass
		named: 'ConcreteNumberTwo'.
	concreteNumberThreeClass := self
		createSubclassOf: abstractNumbersTwoAndThreeClass
		named: 'ConcreteNumberThree'.

	allLeafSubclasses := abstractNumberClass allLeafSubclasses.

	self
		compileCanHandleMethodFor: #(1) inMetaclassOf: concreteNumberOneClass;
		compileCanHandleMethodFor: #(2 3) inMetaclassOf: abstractNumbersTwoAndThreeClass;
		compileCanHandleMethodFor: #(2) inMetaclassOf: concreteNumberTwoClass;
		compileCanHandleMethodFor: #(3) inMetaclassOf: concreteNumberThreeClass.

	self
		compileCanHandleMethodFor: #(1) with: 'one' inMetaclassOf: concreteNumberOneClass;
		compileCanHandleMethodFor: #(2 3)
			with: 'two or three'
			inMetaclassOf: abstractNumbersTwoAndThreeClass;
		compileCanHandleMethodFor: #(2) with: 'two' inMetaclassOf: concreteNumberTwoClass;
		compileCanHandleMethodFor: #(3) with: 'three' inMetaclassOf: concreteNumberThreeClass
]

{ #category : #running }
SuitableClassFinderTest >> tearDown [

	abstractNumberClass removeFromSystem.
	concreteNumberOneClass removeFromSystem.
	abstractNumbersTwoAndThreeClass removeFromSystem.
	concreteNumberTwoClass removeFromSystem.
	concreteNumberThreeClass removeFromSystem.

	super tearDown
]

{ #category : #tests }
SuitableClassFinderTest >> test01FindDirectSubclassOfSuitableFor [

	self
		assert: ( SuitableClassFinder findDirectSubclassOf: abstractNumberClass suitableFor: 1 ) value
		equals: concreteNumberOneClass.

	self
		assert: ( SuitableClassFinder findDirectSubclassOf: abstractNumberClass suitableFor: 3 ) value
		equals: abstractNumbersTwoAndThreeClass
]

{ #category : #tests }
SuitableClassFinderTest >> test02FindDirectSubclassOfSuitableForIfNoneDefault [

	self
		should: [ ( SuitableClassFinder findDirectSubclassOf: abstractNumberClass suitableFor: 5 ) value ]
		raise: ProgrammingError
		withMessageText:
			#'No class is suitable for handling 5. Classes selected for analysis were ConcreteNumberOne and AbstractNumbersTwoAndThree.'
]

{ #category : #tests }
SuitableClassFinderTest >> test03FindDirectSubclassOfSuitableForIfNoneExplicit [

	| expectedScenario |

	expectedScenario := 'not found!'.

	self
		assert:
			( SuitableClassFinder
				findDirectSubclassOf: abstractNumberClass
				suitableFor: 1
				ifNone: [ :suitableClassFinder | self fail ] ) value
		equals: concreteNumberOneClass.

	self
		assert:
			( SuitableClassFinder
				findDirectSubclassOf: abstractNumberClass
				suitableFor: 5
				ifNone: [ :suitableClassFinder | expectedScenario ] ) value
		equals: expectedScenario
]

{ #category : #tests }
SuitableClassFinderTest >> test04FindDirectSubclassOfSuitableForIfNoneifMultipleDefault [

	| anotherConcreteNumberOneClass expectedMultipleClassNames |

	anotherConcreteNumberOneClass := self
		createSubclassOf: abstractNumberClass
		named: 'AnotherConcreteNumberOne'.

	self compileCanHandleMethodFor: #(1) inMetaclassOf: anotherConcreteNumberOneClass.

	expectedMultipleClassNames := 'ConcreteNumberOne and AnotherConcreteNumberOne'.

	self
		should: [ ( SuitableClassFinder
				findDirectSubclassOf: abstractNumberClass
				suitableFor: 1
				ifNone: [ self fail ] ) value
			]
		raise: ProgrammingError
		withMessageText: ( #'Multiple classes can handle 1. They are <1s>.' expandMacrosWith: expectedMultipleClassNames ).

	anotherConcreteNumberOneClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test05FindDirectSubclassOfSuitableForIfNoneifMultipleExplicit [

	| anotherConcreteNumberOneClass expectedScenario |

	anotherConcreteNumberOneClass := self
		createSubclassOf: abstractNumberClass
		named: 'AnotherConcreteNumberOne'.

	self compileCanHandleMethodFor: #(1) inMetaclassOf: anotherConcreteNumberOneClass.

	expectedScenario := 'multiple classes!'.

	self
		assert:
			( SuitableClassFinder
				findDirectSubclassOf: abstractNumberClass
				suitableFor: 1
				ifMultiple: [ :suitableClassFinder :classes | expectedScenario ]
				ifNone: [ self fail ] ) value
		equals: expectedScenario.

	anotherConcreteNumberOneClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test06FindDirectSubclassOfSuitableForWith [

	self
		assert: ( SuitableClassFinder findDirectSubclassOf: abstractNumberClass suitableFor: 1 with: 'one' ) value
		equals: concreteNumberOneClass.

	self
		assert:
			( SuitableClassFinder findDirectSubclassOf: abstractNumberClass suitableFor: 3 with: 'two or three' )
				value
		equals: abstractNumbersTwoAndThreeClass
]

{ #category : #tests }
SuitableClassFinderTest >> test07FindDirectSubclassOfSuitableForWithForIfNoneDefault [

	self
		should:
			[ ( SuitableClassFinder findDirectSubclassOf: abstractNumberClass suitableFor: 5 with: 'one' ) value ]
		raise: ProgrammingError
		withMessageText:
			#'No class is suitable for handling 5 and one. Classes selected for analysis were ConcreteNumberOne and AbstractNumbersTwoAndThree.'
]

{ #category : #tests }
SuitableClassFinderTest >> test08FindDirectSubclassOfSuitableForWithIfNoneExplicit [

	| expectedScenario |

	expectedScenario := 'not found!'.

	self
		assert:
			( SuitableClassFinder
				findDirectSubclassOf: abstractNumberClass
				suitableFor: 1
				with: 'one'
				ifNone: [ :suitableClassFinder | self fail ] ) value
		equals: concreteNumberOneClass.

	self
		assert:
			( SuitableClassFinder
				findDirectSubclassOf: abstractNumberClass
				suitableFor: 5
				with: 'five'
				ifNone: [ :suitableClassFinder | expectedScenario ] ) value
		equals: expectedScenario
]

{ #category : #tests }
SuitableClassFinderTest >> test09FindDirectSubclassOfSuitableForIfNoneifMultipleDefault [

	| anotherConcreteNumberOneClass expectedMultipleClassNames |

	anotherConcreteNumberOneClass := self
		createSubclassOf: abstractNumberClass
		named: 'AnotherConcreteNumberOne'.

	self compileCanHandleMethodFor: #(1) with: 'one' inMetaclassOf: anotherConcreteNumberOneClass.

	expectedMultipleClassNames := 'ConcreteNumberOne and AnotherConcreteNumberOne'.

	self
		should: [ ( SuitableClassFinder
				findDirectSubclassOf: abstractNumberClass
				suitableFor: 1
				with: 'one'
				ifNone: [ self fail ] ) value
			]
		raise: ProgrammingError
		withMessageText:
			( #'Multiple classes can handle 1 and one. They are <1s>.'
				expandMacrosWith: expectedMultipleClassNames ).

	anotherConcreteNumberOneClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test10FindDirectSubclassOfSuitableForIfNoneifMultipleExplicit [

	| anotherConcreteNumberOneClass expectedScenario |

	anotherConcreteNumberOneClass := self
		createSubclassOf: abstractNumberClass
		named: 'AnotherConcreteNumberOne'.

	self compileCanHandleMethodFor: #(1) with: 'one' inMetaclassOf: anotherConcreteNumberOneClass.

	expectedScenario := 'multiple classes!'.

	self
		assert:
			( SuitableClassFinder
				findDirectSubclassOf: abstractNumberClass
				suitableFor: 1
				with: 'one'
				ifMultiple: [ :suitableClassFinder :classes | expectedScenario ]
				ifNone: [ self fail ] ) value
		equals: expectedScenario.

	anotherConcreteNumberOneClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test11FindSubclassOfSuitableFor [

	self
		assert: ( SuitableClassFinder findSubclassOf: abstractNumberClass suitableFor: 1 ) value
		equals: concreteNumberOneClass.

	self
		assert: ( SuitableClassFinder findSubclassOf: abstractNumberClass suitableFor: 3 ) value
		equals: concreteNumberThreeClass
]

{ #category : #tests }
SuitableClassFinderTest >> test12FindSubclassOfSuitableForIfNoneDefault [

	self
		should: [ ( SuitableClassFinder findSubclassOf: abstractNumberClass suitableFor: 5 ) value ]
		raise: ProgrammingError
		withMessageText:
			#'No class is suitable for handling 5. Classes selected for analysis were ConcreteNumberOne, ConcreteNumberTwo and ConcreteNumberThree.'
]

{ #category : #tests }
SuitableClassFinderTest >> test13FindSubclassOfSuitableForIfNoneExplicit [

	| expectedScenario |

	expectedScenario := 'not found!'.

	self
		assert:
			( SuitableClassFinder
				findSubclassOf: abstractNumberClass
				suitableFor: 2
				ifNone: [ :suitableClassFinder | self fail ] ) value
		equals: concreteNumberTwoClass.

	self
		assert:
			( SuitableClassFinder
				findSubclassOf: abstractNumberClass
				suitableFor: 5
				ifNone: [ :suitableClassFinder | expectedScenario ] ) value
		equals: expectedScenario
]

{ #category : #tests }
SuitableClassFinderTest >> test14FindSubclassOfSuitableForIfNoneifMultipleDefault [

	| anotherConcreteNumberTwoClass expectedMultipleClassNames |

	anotherConcreteNumberTwoClass := self
		createSubclassOf: abstractNumbersTwoAndThreeClass
		named: 'AnotherConcreteNumberTwo'.

	self compileCanHandleMethodFor: #(2) inMetaclassOf: abstractNumberClass.

	expectedMultipleClassNames := 'ConcreteNumberTwo and AnotherConcreteNumberTwo'.

	self
		should: [ ( SuitableClassFinder findSubclassOf: abstractNumberClass suitableFor: 2 ifNone: [ self fail ] )
				value
			]
		raise: ProgrammingError
		withMessageText: ( #'Multiple classes can handle 2. They are <1s>.' expandMacrosWith: expectedMultipleClassNames ).

	anotherConcreteNumberTwoClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test15FindSubclassOfSuitableForIfNoneifMultipleExplicit [

	| anotherConcreteNumberTwoClass expectedScenario |

	anotherConcreteNumberTwoClass := self
		createSubclassOf: abstractNumberClass
		named: 'AnotherConcreteNumberTwo'.

	self compileCanHandleMethodFor: #(2) inMetaclassOf: abstractNumberClass.

	expectedScenario := 'multiple classes!'.

	self
		assert:
			( SuitableClassFinder
				findDirectSubclassOf: abstractNumberClass
				suitableFor: 2
				ifMultiple: [ :suitableClassFinder :classes | expectedScenario ]
				ifNone: [ self fail ] ) value
		equals: expectedScenario.

	anotherConcreteNumberTwoClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test16FindSubclassOfSuitableForWith [

	self
		assert: ( SuitableClassFinder findSubclassOf: abstractNumberClass suitableFor: 1 with: 'one' ) value
		equals: concreteNumberOneClass.

	self
		assert: ( SuitableClassFinder findSubclassOf: abstractNumberClass suitableFor: 3 with: 'three' ) value
		equals: concreteNumberThreeClass
]

{ #category : #tests }
SuitableClassFinderTest >> test17FindSubclassOfSuitableForWithIfNoneDefault [

	self
		should: [ ( SuitableClassFinder findSubclassOf: abstractNumberClass suitableFor: 5 ) value ]
		raise: ProgrammingError
		withMessageText:
			#'No class is suitable for handling 5. Classes selected for analysis were ConcreteNumberOne, ConcreteNumberTwo and ConcreteNumberThree.'
]

{ #category : #tests }
SuitableClassFinderTest >> test18FindSubclassOfSuitableForWithIfNoneExplicit [

	| expectedScenario |

	expectedScenario := 'not found!'.

	self
		assert:
			( SuitableClassFinder
				findSubclassOf: abstractNumberClass
				suitableFor: 2
				with: 'two'
				ifNone: [ :suitableClassFinder | self fail ] ) value
		equals: concreteNumberTwoClass.

	self
		assert:
			( SuitableClassFinder
				findSubclassOf: abstractNumberClass
				suitableFor: 5
				with: 'five'
				ifNone: [ :suitableClassFinder | expectedScenario ] ) value
		equals: expectedScenario
]

{ #category : #tests }
SuitableClassFinderTest >> test19FindSubclassOfSuitableForWithIfNoneifMultipleDefault [

	| anotherConcreteNumberTwoClass expectedMultipleClassNames |

	anotherConcreteNumberTwoClass := self
		createSubclassOf: abstractNumbersTwoAndThreeClass
		named: 'AnotherConcreteNumberTwo'.

	self compileCanHandleMethodFor: #(2) with: 'two' inMetaclassOf: anotherConcreteNumberTwoClass.

	expectedMultipleClassNames := 'ConcreteNumberTwo and AnotherConcreteNumberTwo'.

	self
		should: [ ( SuitableClassFinder
				findSubclassOf: abstractNumberClass
				suitableFor: 2
				with: 'two'
				ifNone: [ self fail ] ) value
			]
		raise: ProgrammingError
		withMessageText:
			( #'Multiple classes can handle 2 and two. They are <1s>.'
				expandMacrosWith: expectedMultipleClassNames ).

	anotherConcreteNumberTwoClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test20FindSubclassOfSuitableForWithIfNoneifMultipleExplicit [

	| anotherConcreteNumberTwoClass expectedScenario |

	anotherConcreteNumberTwoClass := self
		createSubclassOf: abstractNumberClass
		named: 'AnotherConcreteNumberTwo'.

	self compileCanHandleMethodFor: #(2) with: 'two' inMetaclassOf: anotherConcreteNumberTwoClass.

	expectedScenario := 'multiple classes!'.

	self
		assert:
			( SuitableClassFinder
				findSubclassOf: abstractNumberClass
				suitableFor: 2
				with: 'two'
				ifMultiple: [ :suitableClassFinder :classes | expectedScenario ]
				ifNone: [ self fail ] ) value
		equals: expectedScenario.

	anotherConcreteNumberTwoClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test21FindInSuitableFor [

	self
		assert: ( SuitableClassFinder findIn: allLeafSubclasses suitableFor: 1 ) value
		equals: concreteNumberOneClass.

	self
		assert: ( SuitableClassFinder findIn: allLeafSubclasses suitableFor: 3 ) value
		equals: concreteNumberThreeClass
]

{ #category : #tests }
SuitableClassFinderTest >> test22FindInSuitableForIfNoneDefault [

	self
		should: [ ( SuitableClassFinder findIn: allLeafSubclasses suitableFor: 5 ) value ]
		raise: ProgrammingError
		withMessageText:
			#'No class is suitable for handling 5. Classes selected for analysis were ConcreteNumberOne, ConcreteNumberTwo and ConcreteNumberThree.'
]

{ #category : #tests }
SuitableClassFinderTest >> test23FindInSuitableForIfNoneExplicit [

	| expectedScenario |

	expectedScenario := 'not found!'.

	self
		assert:
			( SuitableClassFinder
				findIn: allLeafSubclasses
				suitableFor: 2
				ifNone: [ :suitableClassFinder | self fail ] ) value
		equals: concreteNumberTwoClass.

	self
		assert:
			( SuitableClassFinder
				findIn: allLeafSubclasses
				suitableFor: 5
				ifNone: [ :suitableClassFinder | expectedScenario ] ) value
		equals: expectedScenario
]

{ #category : #tests }
SuitableClassFinderTest >> test24FindInSuitableForIfNoneifMultipleDefault [

	| anotherConcreteNumberTwoClass expectedMultipleClassNames allLeafSubclassesWithNewConcreteClass |

	anotherConcreteNumberTwoClass := self
		createSubclassOf: abstractNumbersTwoAndThreeClass
		named: 'AnotherConcreteNumberTwo'.

	self compileCanHandleMethodFor: #(2) inMetaclassOf: abstractNumberClass.

	expectedMultipleClassNames := 'ConcreteNumberTwo and AnotherConcreteNumberTwo'.

	allLeafSubclassesWithNewConcreteClass := OrderedCollection new
		addAll: allLeafSubclasses;
		add: anotherConcreteNumberTwoClass;
		yourself.

	self
		should: [ ( SuitableClassFinder
				findIn: allLeafSubclassesWithNewConcreteClass
				suitableFor: 2
				ifNone: [ self fail ] ) value
			]
		raise: ProgrammingError
		withMessageText: ( #'Multiple classes can handle 2. They are <1s>.' expandMacrosWith: expectedMultipleClassNames ).

	anotherConcreteNumberTwoClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test25FindInSuitableForIfNoneifMultipleExplicit [

	| anotherConcreteNumberTwoClass expectedScenario allLeafSubclassesWithNewConcreteClass |

	anotherConcreteNumberTwoClass := self
		createSubclassOf: abstractNumberClass
		named: 'AnotherConcreteNumberTwo'.

	self compileCanHandleMethodFor: #(2) inMetaclassOf: abstractNumberClass.

	allLeafSubclassesWithNewConcreteClass := OrderedCollection new
		addAll: allLeafSubclasses;
		add: anotherConcreteNumberTwoClass;
		yourself.

	expectedScenario := 'multiple classes!'.

	self
		assert:
			( SuitableClassFinder
				findIn: allLeafSubclassesWithNewConcreteClass
				suitableFor: 2
				ifMultiple: [ :suitableClassFinder :classes | expectedScenario ]
				ifNone: [ self fail ] ) value
		equals: expectedScenario.

	anotherConcreteNumberTwoClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test26FindInSuitableForWith [

	self
		assert: ( SuitableClassFinder findIn: allLeafSubclasses suitableFor: 1 with: 'one' ) value
		equals: concreteNumberOneClass.

	self
		assert: ( SuitableClassFinder findIn: allLeafSubclasses suitableFor: 3 with: 'three' ) value
		equals: concreteNumberThreeClass
]

{ #category : #tests }
SuitableClassFinderTest >> test27FindInSuitableForWithIfNoneDefault [

	self
		should: [ ( SuitableClassFinder findIn: allLeafSubclasses suitableFor: 5 ) value ]
		raise: ProgrammingError
		withMessageText:
			#'No class is suitable for handling 5. Classes selected for analysis were ConcreteNumberOne, ConcreteNumberTwo and ConcreteNumberThree.'
]

{ #category : #tests }
SuitableClassFinderTest >> test28FindInSuitableForWithIfNoneExplicit [

	| expectedScenario |

	expectedScenario := 'not found!'.

	self
		assert:
			( SuitableClassFinder
				findIn: allLeafSubclasses
				suitableFor: 2
				with: 'two'
				ifNone: [ :suitableClassFinder | self fail ] ) value
		equals: concreteNumberTwoClass.

	self
		assert:
			( SuitableClassFinder
				findIn: allLeafSubclasses
				suitableFor: 5
				with: 'five'
				ifNone: [ :suitableClassFinder | expectedScenario ] ) value
		equals: expectedScenario
]

{ #category : #tests }
SuitableClassFinderTest >> test29FindInSuitableForWithIfNoneifMultipleDefault [

	| anotherConcreteNumberTwoClass expectedMultipleClassNames allLeafSubclassesWithNewConcreteClass |

	anotherConcreteNumberTwoClass := self
		createSubclassOf: abstractNumbersTwoAndThreeClass
		named: 'AnotherConcreteNumberTwo'.

	self compileCanHandleMethodFor: #(2) with: 'two' inMetaclassOf: anotherConcreteNumberTwoClass.

	allLeafSubclassesWithNewConcreteClass := OrderedCollection new
		addAll: allLeafSubclasses;
		add: anotherConcreteNumberTwoClass;
		yourself.

	expectedMultipleClassNames := 'ConcreteNumberTwo and AnotherConcreteNumberTwo'.

	self
		should: [ ( SuitableClassFinder
				findIn: allLeafSubclassesWithNewConcreteClass
				suitableFor: 2
				with: 'two'
				ifNone: [ self fail ] ) value
			]
		raise: ProgrammingError
		withMessageText:
			( #'Multiple classes can handle 2 and two. They are <1s>.'
				expandMacrosWith: expectedMultipleClassNames ).

	anotherConcreteNumberTwoClass removeFromSystem
]

{ #category : #tests }
SuitableClassFinderTest >> test30FindInSuitableForWithIfNoneifMultipleExplicit [

	| anotherConcreteNumberTwoClass expectedScenario allLeafSubclassesWithNewConcreteClass |

	anotherConcreteNumberTwoClass := self
		createSubclassOf: abstractNumberClass
		named: 'AnotherConcreteNumberTwo'.

	self compileCanHandleMethodFor: #(2) with: 'two' inMetaclassOf: anotherConcreteNumberTwoClass.

	allLeafSubclassesWithNewConcreteClass := OrderedCollection new
		addAll: allLeafSubclasses;
		add: anotherConcreteNumberTwoClass;
		yourself.

	expectedScenario := 'multiple classes!'.

	self
		assert:
			( SuitableClassFinder
				findIn: allLeafSubclassesWithNewConcreteClass
				suitableFor: 2
				with: 'two'
				ifMultiple: [ :suitableClassFinder :classes | expectedScenario ]
				ifNone: [ self fail ] ) value
		equals: expectedScenario.

	anotherConcreteNumberTwoClass removeFromSystem
]
