Extension { #name : #DAPackageRelationGraph }

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> addPackageOf: aLiteral from: aMethod asClassReferenceDependencyFrom: aDAPackage [

	| literalPackage |

	literalPackage := self packageForBehavior: aLiteral value.
	self addPackage: literalPackage.
	aDAPackage add: ( ( DAReferenceDependency from: aDAPackage to: literalPackage )
			  theClass: aMethod methodClass;
			  selector: aMethod method selector asSymbol;
			  reference: aLiteral value;
			  method: aMethod;
			  yourself )
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> addPackageOf: aSelector from: aMethod asMessageSendReferenceDependencyFrom: aDAPackage [

	| methodImplementors potentialPackages |

	methodImplementors := self implementorsOf: aSelector differentFrom: aMethod.

	potentialPackages := methodImplementors collect: [ :aMethodImplementor | 
		                     self packageForMethod: aMethodImplementor ]
		                     as: Set.

	potentialPackages size = 1
		ifTrue: [ 
			| foundPackage |

			foundPackage := potentialPackages anyOne.
			self addPackage: foundPackage.
			aDAPackage add: ( DAMessageSendReferenceDependency from: aDAPackage
					  to: foundPackage
					  dueToSendOf: aSelector
					  in: aMethod )
			]
		ifFalse: [ "Since the proper receiver of the message cannot be determined, it will be a potential dependency which should be manually resolved."
			 ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> findClassesReferencesIn: aCompileCodeCollection of: aMethod for: aDAPackage [

	aCompileCodeCollection do: [ :aCompiledCode | 
		aCompiledCode literals select: [ :literal | self isReference: literal ]
			thenDo: [ :literal | 
			self addPackageOf: literal from: aMethod asClassReferenceDependencyFrom: aDAPackage ]
		]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> findMessagesSendReferencesIn: aSelectorCollection of: aMethod for: aDAPackage [

	aSelectorCollection do: [ :aSelector | 
		self addPackageOf: aSelector from: aMethod asMessageSendReferenceDependencyFrom: aDAPackage ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> findReferencesIn: aMethod for: aDAPackage [

	| compiledMethod |

	compiledMethod := aMethod compiledMethod.
	compiledMethod ifNotNil: [ 
		self findClassesReferencesIn: compiledMethod withAllBlocks of: aMethod for: aDAPackage ].

	self findMessagesSendReferencesIn: aMethod messages of: aMethod for: aDAPackage
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> implementorsOf: aSelector differentFrom: aMethod [

	"This is done to avoid considering cases when an object implements a method with the same selector as another object since it's delegating it"

	^ aSelector implementors reject: [ :method | method = aMethod ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> packageForMethod: aMethod [

	| packageName |

	packageName := aMethod package name.
	^ self packages detect: [ :each | each rPackageSet packageName = packageName ]
		  ifNone: [ self daPackageWith: packageName ]
]
