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

	methodImplementors := self implementorsOf: aLiteral differentFrom: aRGMethodDefinition.

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
		do: [ :literal | 
			( self isReference: literal )
				ifTrue: [ self addPackageOf: literal from: aRGMethodDefinition asClassReferenceDependencyFrom: aDAPackage ]
				ifFalse: [ ( self referencesSelector: literal )
						ifTrue: [ self
								addPackageOf: literal
								from: aRGMethodDefinition
								asMessageSendReferenceDependencyFrom: aDAPackage
							]
					]
			]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> implementorsOf: aLiteral differentFrom: aRGMethodDefinition [

	"This is done to avoid considering cases when an object implements a method with the same selector as another object since it's delegating it"

	^ aLiteral implementors reject: [ :method | method = aRGMethodDefinition ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> packageForMethod: aRGMethodDefinition [

	| packageName |

	packageName := aRGMethodDefinition package name.
	^ self packages
		detect: [ :each | each rPackageSet packageName = packageName ]
		ifNone: [ self daPackageWith: packageName ]
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions' }
DAPackageRelationGraph >> referencesSelector: aLiteral [

	^ aLiteral isSymbol
]
