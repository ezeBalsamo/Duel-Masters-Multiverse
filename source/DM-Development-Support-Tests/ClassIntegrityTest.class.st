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
