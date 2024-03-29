Class {
	#name : #ClassIntegrityTest,
	#superclass : #DevelopmentTest,
	#category : #'DM-Development-Support-Tests'
}

{ #category : #'private - asserting' }
ClassIntegrityTest >> assert: aClass dontHaveEmptyCategoriesLoggingFailuresOn: aStream [

	"For some reason, when I extend ClassDescription, ClassOrganization and ProtocolOrganizer, then code coverages fails.
	Since I only need this behaviour in this test, I implemented here."

	( self emptyCategoriesOf: aClass )
		ifNotEmpty: [ :categories | self log: categories asEmptyCategoriesOf: aClass on: aStream ]
]

{ #category : #'private - asserting' }
ClassIntegrityTest >> assert: aClass dontHaveUncategorizedMethodsLoggingFailuresOn: aStream [

	aClass uncategorizedSelectors
		ifNotEmpty: [ :selectors | self log: selectors asUncategorizedSelectorsOf: aClass on: aStream ]
]

{ #category : #'private - asserting' }
ClassIntegrityTest >> assert: aClass isWellCompiledLoggingFailuresOn: aStream [

	"I can't send #recompile because it breaks coverage, so I copy the implementation here."

	aClass localSelectors
		do: [ :selector | self recompile: selector from: aClass loggingFailuresOn: aStream ]
]

{ #category : #'private - asserting' }
ClassIntegrityTest >> assert: aClass orItsMetaclassDefinesProtocolLoggingFailuresOn: aStream [

	( self definesProtocol: aClass )
		ifFalse: [ self log: ( '<1p> does not define protocol.' expandMacrosWith: aClass ) on: aStream ]
]

{ #category : #'private - testing' }
ClassIntegrityTest >> definesProtocol: aClass [

	^ aClass hasMethods or: [ aClass classSide hasMethods ]
]

{ #category : #'private - accessing' }
ClassIntegrityTest >> emptyCategoriesOf: aClass [

	| protocolOrganizer |

	protocolOrganizer := aClass organization protocolOrganizer.
	^ protocolOrganizer protocols select: #canBeRemoved thenCollect: #name
]

{ #category : #'private - logging' }
ClassIntegrityTest >> log: aCategoryCollection asEmptyCategoriesOf: aClass on: aStream [

	<ignoreForCoverage>
	aCategoryCollection
		do:
			[ :category | self log: ( '<1p>: Category <2s> is empty.' expandMacrosWith: aClass with: category ) on: aStream ]
]

{ #category : #'private - logging' }
ClassIntegrityTest >> log: aSelectorsCollection asUncategorizedSelectorsOf: aClass on: aStream [

	<ignoreForCoverage>
	aSelectorsCollection
		do:
			[ :selector | self log: ( '<1p>>>#<2s> is uncategorized.' expandMacrosWith: aClass with: selector ) on: aStream ]
]

{ #category : #'private - evaluating' }
ClassIntegrityTest >> recompile: aSelector from: aClass loggingFailuresOn: aStream [

	| failureLoggingBlock methodDefinition newMethodDefinition |

	failureLoggingBlock := [ 
	                       self
		                       log:
			                       ( '<1p>>><2p> has changed after recompiling, so it''s bad compiled.' 
				                         expandMacrosWith: aClass
				                         with: aSelector )
		                       on: aStream
	                       ].

	methodDefinition := aClass compiledMethodAt: aSelector.
	newMethodDefinition := aClass compiler
		                       source: ( aClass sourceCodeAt: aSelector );
		                       class: aClass;
		                       failBlock: failureLoggingBlock;
		                       compiledMethodTrailer: methodDefinition trailer;
		                       compile.

	methodDefinition = newMethodDefinition ifFalse: failureLoggingBlock
]

{ #category : #tests }
ClassIntegrityTest >> test01ClassesDoNotHaveUncategorizedMethods [

	self
		runLoggingFailuresOn: [ :stream | 
			self
				withAllOwnedClassesDo: [ :class | 
					self
						assert: class dontHaveUncategorizedMethodsLoggingFailuresOn: stream;
						assert: class classSide dontHaveUncategorizedMethodsLoggingFailuresOn: stream
					]
			]
]

{ #category : #tests }
ClassIntegrityTest >> test02ClassesDoNotHaveEmptyCategories [

	self
		runLoggingFailuresOn: [ :stream | 
			self
				withAllOwnedClassesDo: [ :class | 
					self
						assert: class dontHaveEmptyCategoriesLoggingFailuresOn: stream;
						assert: class classSide dontHaveEmptyCategoriesLoggingFailuresOn: stream
					]
			]
]

{ #category : #tests }
ClassIntegrityTest >> test03ClassesMustDefineProtocol [

	self
		runLoggingFailuresOn: [ :stream | 
			self
				withAllOwnedClassesWithoutExceptionsDo: [ :class | self assert: class orItsMetaclassDefinesProtocolLoggingFailuresOn: stream ]
			]
]

{ #category : #tests }
ClassIntegrityTest >> test04ClassesAreWellCompiled [

	self
		runLoggingFailuresOn: [ :stream | 
			self
				withAllOwnedClassesDo: [ :class | 
					self
						assert: class isWellCompiledLoggingFailuresOn: stream;
						assert: class classSide isWellCompiledLoggingFailuresOn: stream
					]
			]
]

{ #category : #'private - accessing' }
ClassIntegrityTest >> withAllOwnedClassesWithoutExceptionsDo: aBlockClosure [

	self ownedClasses reject: [ :class | class isA: Exception class ] thenDo: aBlockClosure
]
