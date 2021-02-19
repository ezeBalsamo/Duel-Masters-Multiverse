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
DAPackageRelationGraph >> addPackageOf: aLiteral from: aRGMethodDefinition asMessageSendReferenceDependencyFrom: aDAPackage [

	| methodImplementors |

	methodImplementors := self implementorsOf: aLiteral differentFrom: aRGMethodDefinition methodClass.

	methodImplementors size = 1
		ifTrue: [ | literalPackage |

			literalPackage := self packageForMethod: methodImplementors anyOne.
			self addPackage: literalPackage.
			aDAPackage
				add:
					( DAMessageSendReferenceDependency
						from: aDAPackage
						to: literalPackage
						dueToSendOf: aLiteral
						in: aRGMethodDefinition )
			]
		ifFalse:
			[ "Since the proper receiver of the message cannot be determined, it will be a potential dependency which should be manually resolved." ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> findReferencesIn: aRGMethodDefinition for: aDAPackage [

	| compiledMethod |

	compiledMethod := aRGMethodDefinition compiledMethod.
	compiledMethod
		ifNotNil: [ self findReferencesIn: compiledMethod literals of: aRGMethodDefinition for: aDAPackage ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> findReferencesIn: aLiteralCollection of: aRGMethodDefinition for: aDAPackage [

	aLiteralCollection
		select: [ :literal | self isReferencingASelector: literal ]
		thenDo: [ :literal | 
			self
				addPackageOf: literal
				from: aRGMethodDefinition
				asMessageSendReferenceDependencyFrom: aDAPackage
			].

	aLiteralCollection
		select: [ :literal | self isReference: literal ]
		thenDo:
			[ :literal | self addPackageOf: literal from: aRGMethodDefinition asClassReferenceDependencyFrom: aDAPackage ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> implementorsOf: aLiteral differentFrom: aClass [

	^ aLiteral implementors reject: [ :method | method methodClass = aClass ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> isReferencingASelector: aLiteral [

	^ aLiteral isSymbol
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> packageForMethod: aRGMethodDefinition [

	| packageName |

	packageName := aRGMethodDefinition package name.
	^ self packages
		detect: [ :each | each rPackageSet packageName = packageName ]
		ifNone: [ self daPackageWith: packageName ]
]
