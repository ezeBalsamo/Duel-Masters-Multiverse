Class {
	#name : #WikitextTemplate,
	#superclass : #Object,
	#instVars : [
		'wikitextArguments',
		'name'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - asserting' }
WikitextTemplate class >> assertNoRepeatedNameIn: aWikitextArgumentCollection [

	aWikitextArgumentCollection
		ifEmpty: [ "do nothing.- ebalsamo" ]
		ifNotEmpty: [ self
				assertNoWikitextArgumentIn: aWikitextArgumentCollection withoutFirst
				namedSameThan: aWikitextArgumentCollection first
			]
]

{ #category : #'private - asserting' }
WikitextTemplate class >> assertNoUnnamedArgumentsWithSameContentIn: aWikitextArgumentCollection [

	| unnamedWikitextArguments |

	unnamedWikitextArguments := aWikitextArgumentCollection select: #isUnnamed.

	unnamedWikitextArguments
		ifEmpty: [ "do nothing. -ebalsamo" ]
		ifNotEmpty: [ self
				assertNoUnnamedWikitextArgumentIn: unnamedWikitextArguments withoutFirst
				withSameContentThan: unnamedWikitextArguments first
			]
]

{ #category : #'private - asserting' }
WikitextTemplate class >> assertNoUnnamedWikitextArgumentIn: aWikitextArgumentCollection
	withSameContentThan: aWikitextArgumentToCompare [


	aWikitextArgumentCollection
		detect: [ :aWikitextArgument | aWikitextArgument hasSameContentThan: aWikitextArgumentToCompare ]
		ifFound: [ InstanceCreationFailed
				signal: 'Wikitext Template can''t have more than one unnamed argument with the same content.'
			]
		ifNone: [ self assertNoUnnamedArgumentsWithSameContentIn: aWikitextArgumentCollection ]
]

{ #category : #'private - asserting' }
WikitextTemplate class >> assertNoWikitextArgumentIn: aWikitextArgumentCollection namedSameThan: aWikitextArgumentToCompare [

	aWikitextArgumentCollection
		detect: [ :aWikitextArgument | aWikitextArgument hasSameNameThan: aWikitextArgumentToCompare ]
		ifFound: [ InstanceCreationFailed
				signal: 'Wikitext Template can''t have more than one argument with the same name.'
			]
		ifNone: [ self assertNoRepeatedNameIn: aWikitextArgumentCollection ]
]

{ #category : #'instance creation' }
WikitextTemplate class >> named: aTemplateName withArgument: aWikitextArgument [

	^ self named: aTemplateName withArguments: {aWikitextArgument}
]

{ #category : #'instance creation' }
WikitextTemplate class >> named: aTemplateName withArguments: aWikitextArgumentCollection [

	self
		assertNoRepeatedNameIn: aWikitextArgumentCollection;
		assertNoUnnamedArgumentsWithSameContentIn: aWikitextArgumentCollection.

	^ self new initializeNamed: aTemplateName withArguments: aWikitextArgumentCollection
]

{ #category : #'instance creation' }
WikitextTemplate class >> withoutArgumentsNamed: aTemplateName [

	^ self named: aTemplateName withArguments: #()
]

{ #category : #testing }
WikitextTemplate >> hasArgumentNamed: aPotentialName withContent: aPotentialContent [

	^ wikitextArguments
		detect: [ :aWikitextArgument | aWikitextArgument isNamed: aPotentialName ]
		ifFound: [ :foundWikitextArgument | foundWikitextArgument hasContent: aPotentialContent ]
		ifNone: [ false ]
]

{ #category : #testing }
WikitextTemplate >> hasArguments [

	^ wikitextArguments notEmpty
]

{ #category : #'testing - private' }
WikitextTemplate >> hasEquivalentArgument: aPotentialWikitextArgument [

	^ wikitextArguments
		anySatisfy: [ :aWikitextArgument | aWikitextArgument isEquivalentTo: aPotentialWikitextArgument ]
]

{ #category : #'testing - private' }
WikitextTemplate >> hasEquivalentArguments: aWikitextTemplate [

	^ wikitextArguments
		allSatisfy: [ :aWikitextArgument | aWikitextTemplate hasEquivalentArgument: aWikitextArgument ]
]

{ #category : #testing }
WikitextTemplate >> hasUnnamedArgumentWithContent: aContent [

	^ self unnamedWikitextArguments
		detect: [ :aWikitextArgument | aWikitextArgument hasContent: aContent ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #initialization }
WikitextTemplate >> initializeNamed: aTemplateName withArguments: aWikitextArgumentCollection [

	name := aTemplateName.
	wikitextArguments := aWikitextArgumentCollection
]

{ #category : #testing }
WikitextTemplate >> isEquivalentTo: aWikitextTemplate [

	^ ( aWikitextTemplate isNamed: name )
		and: [ ( self hasEquivalentArguments: aWikitextTemplate )
				and: [ aWikitextTemplate hasEquivalentArguments: self ]
			]
]

{ #category : #testing }
WikitextTemplate >> isNamed: aPotentialName [

	^ name = aPotentialName
]

{ #category : #accessing }
WikitextTemplate >> unnamedWikitextArguments [

	^ wikitextArguments select: #isUnnamed
]
