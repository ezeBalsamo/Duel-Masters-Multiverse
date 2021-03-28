Class {
	#name : #ClassIntegrityTest,
	#superclass : #DevelopmentTest,
	#category : #'DM-Development-Support-Tests'
}

{ #category : #'private - asserting' }
ClassIntegrityTest >> assert: aClass dontHaveEmptyCategoriesLoggingFailuresOn: aStream [

	aClass emptyCategories
		ifNotEmpty: [ :categories | self log: categories asEmptyCategoriesOf: aClass on: aStream ]
]

{ #category : #'private - asserting' }
ClassIntegrityTest >> assert: aClass dontHaveUncategorizedMethodsLoggingFailuresOn: aStream [

	aClass uncategorizedSelectors
		ifNotEmpty: [ :selectors | self log: selectors asUncategorizedSelectorsOf: aClass on: aStream ]
]

{ #category : #'private - asserting' }
ClassIntegrityTest >> assert: aClass isWellCompiledLoggingFailuresOn: aStream [

	[ aClass recompile ]
		on: Error
		do: [ :signal | 
			self log: signal messageText on: aStream.
			signal pass
			]
]

{ #category : #'private - asserting' }
ClassIntegrityTest >> assert: aClass orItsMetaclassDefinesProtocolLoggingFailuresOn: aStream [

	( self definesProtocol: aClass )
		ifFalse: [ self log: ( '<1p> does not define protocol.' expandMacrosWith: aClass ) on: aStream ]
]

{ #category : #'private - testing' }
ClassIntegrityTest >> definesProtocol: aClass [

	^ aClass hasMethods or: [ aClass class hasMethods ]
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

{ #category : #'private - accessing' }
ClassIntegrityTest >> ownedClasses [

	^ self ownedPackages flatCollect: #definedClasses
]

{ #category : #tests }
ClassIntegrityTest >> test01ClassesDoNotHaveUncategorizedMethods [

	self
		runLoggingFailuresOn: [ :stream | 
			self
				withAllOwnedClassesDo: [ :class | 
					self assert: class dontHaveUncategorizedMethodsLoggingFailuresOn: stream.
					self assert: class class dontHaveUncategorizedMethodsLoggingFailuresOn: stream
					]
			]
]

{ #category : #tests }
ClassIntegrityTest >> test02ClassesDoNotHaveEmptyCategories [

	self
		runLoggingFailuresOn: [ :stream | 
			self
				withAllOwnedClassesDo: [ :class | 
					self assert: class dontHaveEmptyCategoriesLoggingFailuresOn: stream.
					self assert: class class dontHaveEmptyCategoriesLoggingFailuresOn: stream
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
					self assert: class isWellCompiledLoggingFailuresOn: stream.
					self assert: class class isWellCompiledLoggingFailuresOn: stream
					]
			]
]

{ #category : #'private - accessing' }
ClassIntegrityTest >> withAllOwnedClassesDo: aBlockClosure [

	self ownedClasses do: aBlockClosure
]

{ #category : #'private - accessing' }
ClassIntegrityTest >> withAllOwnedClassesWithoutExceptionsDo: aBlockClosure [

	self ownedClasses reject: [ :class | class isA: Exception class ] thenDo: aBlockClosure
]
