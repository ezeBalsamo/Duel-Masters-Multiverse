Extension { #name : #DAPackageRelationGraph }

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> addPackageOf: aLiteral from: aRGMethodDefinition asClassReferenceDependencyFrom: aDAPackage [

	| literalPackage |

	literalPackage := self packageForBehavior: aLiteral value.
	self addPackage: literalPackage.
	aDAPackage
		add:
			( ( DAReferenceDependency from: aDAPackage to: literalPackage )
				theClass: aRGMethodDefinition actualClass;
				selector: aRGMethodDefinition method selector asSymbol;
				reference: aLiteral value;
				method: aRGMethodDefinition;
				yourself )
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> addPackageOf: aSelector from: aRGMethodDefinition asMessageSendReferenceDependencyFrom: aDAPackage [

	| methodImplementors potentialPackages |

	methodImplementors := self implementorsOf: aSelector differentFrom: aRGMethodDefinition.

	potentialPackages := methodImplementors
		collect: [ :aMethodImplementor | self packageForMethod: aMethodImplementor ]
		as: Set.

	potentialPackages size = 1
		ifTrue: [ | foundPackage |

			foundPackage := potentialPackages anyOne.
			self addPackage: foundPackage.
			aDAPackage
				add:
					( DAMessageSendReferenceDependency
						from: aDAPackage
						to: foundPackage
						dueToSendOf: aSelector
						in: aRGMethodDefinition )
			]
		ifFalse:
			[ "Since the proper receiver of the message cannot be determined, it will be a potential dependency which should be manually resolved." ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> findClassesReferencesIn: aLiteralCollection of: aRGMethodDefinition for: aDAPackage [

	aLiteralCollection
		select: [ :literal | self isReference: literal ]
		thenDo:
			[ :literal | self addPackageOf: literal from: aRGMethodDefinition asClassReferenceDependencyFrom: aDAPackage ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> findMessagesSendReferencesIn: aSelectorCollection of: aRGMethodDefinition for: aDAPackage [

	aSelectorCollection
		do: [ :aSelector | 
			self
				addPackageOf: aSelector
				from: aRGMethodDefinition
				asMessageSendReferenceDependencyFrom: aDAPackage
			]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> findReferencesIn: aRGMethodDefinition for: aDAPackage [

	| compiledMethod |

	compiledMethod := aRGMethodDefinition compiledMethod.
	compiledMethod
		ifNotNil: [ self findClassesReferencesIn: compiledMethod literals of: aRGMethodDefinition for: aDAPackage ].

	self
		findMessagesSendReferencesIn: aRGMethodDefinition messages
		of: aRGMethodDefinition
		for: aDAPackage
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> implementorsOf: aSelector differentFrom: aRGMethodDefinition [

	"This is done to avoid considering cases when an object implements a method with the same selector as another object since it's delegating it"

	^ aSelector implementors reject: [ :method | method = aRGMethodDefinition ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> packageForMethod: aRGMethodDefinition [

	| packageName |

	packageName := aRGMethodDefinition package name.
	^ self packages
		detect: [ :each | each rPackageSet packageName = packageName ]
		ifNone: [ self daPackageWith: packageName ]
]
