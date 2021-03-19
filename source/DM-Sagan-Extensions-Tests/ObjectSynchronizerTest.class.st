"
An ObjectSynchronizerTest is a test class for testing the behavior of ObjectSynchronizer
"
Class {
	#name : #ObjectSynchronizerTest,
	#superclass : #TestCase,
	#instVars : [
		'dummyObjectClass',
		'anotherDummyObjectClass'
	],
	#category : #'DM-Sagan-Extensions-Tests'
}

{ #category : #'private - compiling' }
ObjectSynchronizerTest >> compileGetterMethodsIn: aClass [

	( self getterMethodsFor: aClass )
		do: [ :getterMethodToCompile | aClass compile: getterMethodToCompile ]
]

{ #category : #'private - compiling' }
ObjectSynchronizerTest >> compileInitializationMethodIn: aClass [

	aClass compile: ( self initializationMethodFor: aClass )
]

{ #category : #'private - compiling' }
ObjectSynchronizerTest >> compileInstanceCreationMethodInMetaclassOf: aClass [

	aClass class compile: ( self instanceCreationMethodFor: aClass )
]

{ #category : #'private - accessing' }
ObjectSynchronizerTest >> getterMethodsFor: aClass [

	^ aClass instVarNames
		collect: [ :instanceCollaboratorName | '<1s> ^<1s>' expandMacrosWith: instanceCollaboratorName ]
]

{ #category : #'private - accessing' }
ObjectSynchronizerTest >> initializationMethodFor: aClass [

	| instanceCreationMethod initializationMessage instanceVariableNames instanceVariableNamesAssigned |

	instanceCreationMethod := aClass class methods first.
	initializationMessage := ( instanceCreationMethod sourceCode substrings: '^' ) last
		withoutPrefix: 'self new '.

	instanceVariableNames := instanceCreationMethod selector substrings: ':'.
	instanceVariableNamesAssigned := ( CollectionFormatter
		separatingWith: '.'
		applyingToEach: [ :instVarName | '<1s> := a<2s>' expandMacrosWith: instVarName with: instVarName capitalized ] )
		format: instanceVariableNames.

	^ '<1s> <2s>' expandMacrosWith: initializationMessage with: instanceVariableNamesAssigned
]

{ #category : #'private - accessing' }
ObjectSynchronizerTest >> instanceCreationMethodFor: aClass [

	| instanceCreationMessage |

	instanceCreationMessage := ( CollectionFormatter
		separatingWith: ' '
		applyingToEach: [ :instVar | '<1s>: a<2s>' expandMacrosWith: instVar with: instVar capitalized ] )
		format: aClass instVarNames.

	^ '<1s> ^self new initialize<2s>'
		expandMacrosWith: instanceCreationMessage
		with: instanceCreationMessage capitalized
]

{ #category : #running }
ObjectSynchronizerTest >> setUp [

	super setUp.

	dummyObjectClass := Object
		subclass: 'DummyObject'
		instanceVariableNames: 'firstInternalCollaborator secondInternalCollaborator thirdInternalCollaborator'
		classVariableNames: ''
		poolDictionaries: ''
		package: self class category.

	anotherDummyObjectClass := Object
		subclass: 'AnotherDummyObject'
		instanceVariableNames: 'anotherFirstInternalCollaborator'
		classVariableNames: ''
		poolDictionaries: ''
		package: self class category.

	self
		compileInstanceCreationMethodInMetaclassOf: dummyObjectClass;
		compileInstanceCreationMethodInMetaclassOf: anotherDummyObjectClass.

	self
		compileInitializationMethodIn: dummyObjectClass;
		compileInitializationMethodIn: anotherDummyObjectClass.

	self
		compileGetterMethodsIn: dummyObjectClass;
		compileGetterMethodsIn: anotherDummyObjectClass
]

{ #category : #running }
ObjectSynchronizerTest >> tearDown [

	dummyObjectClass removeFromSystem.
	anotherDummyObjectClass removeFromSystem.

	super tearDown
]

{ #category : #tests }
ObjectSynchronizerTest >> test01CantSynchronizeObjectsWhenTheyAreNotFromTheSameClass [

	| dummyObject anotherDummyObject |

	dummyObject := dummyObjectClass
		firstInternalCollaborator: 1
		secondInternalCollaborator: 2
		thirdInternalCollaborator: 3.

	anotherDummyObject := anotherDummyObjectClass anotherFirstInternalCollaborator: 1.

	self
		should: [ ( ObjectSynchronizer
				synchronizingInternalCollaboratorsFrom: dummyObject
				withThoseFrom: anotherDummyObject ) synchronize
			]
		raise: AssertionFailed
		withMessageText:
			'An object of type DummyObject can''t be synchronized with one of type AnotherDummyObject because they are from different classes'
]

{ #category : #tests }
ObjectSynchronizerTest >> test02SynchronizingAllInternalCollaborators [

	| dummyObjectToUpdate updatedDummyObject |

	dummyObjectToUpdate := dummyObjectClass
		firstInternalCollaborator: 1
		secondInternalCollaborator: 2
		thirdInternalCollaborator: 3.

	updatedDummyObject := dummyObjectClass
		firstInternalCollaborator: 10
		secondInternalCollaborator: 20
		thirdInternalCollaborator: 30.

	( ObjectSynchronizer
		synchronizingInternalCollaboratorsFrom: dummyObjectToUpdate
		withThoseFrom: updatedDummyObject ) synchronize.

	self
		assert: ( dummyObjectToUpdate instVarNamed: 'firstInternalCollaborator' ) equals: 10;
		assert: ( dummyObjectToUpdate instVarNamed: 'secondInternalCollaborator' ) equals: 20;
		assert: ( dummyObjectToUpdate instVarNamed: 'thirdInternalCollaborator' ) equals: 30
]

{ #category : #tests }
ObjectSynchronizerTest >> test03SynchronizingAllInternalCollaboratorsExceptOne [

	| dummyObjectToUpdate updatedDummyObject |

	dummyObjectToUpdate := dummyObjectClass
		firstInternalCollaborator: 1
		secondInternalCollaborator: 2
		thirdInternalCollaborator: 3.

	updatedDummyObject := dummyObjectClass
		firstInternalCollaborator: 10
		secondInternalCollaborator: 20
		thirdInternalCollaborator: 30.

	( ObjectSynchronizer
		synchronizingInternalCollaboratorsFrom: dummyObjectToUpdate
		withThoseFrom: updatedDummyObject
		except: 'firstInternalCollaborator' ) synchronize.

	self
		assert: ( dummyObjectToUpdate instVarNamed: 'firstInternalCollaborator' ) equals: 1;
		assert: ( dummyObjectToUpdate instVarNamed: 'secondInternalCollaborator' ) equals: 20;
		assert: ( dummyObjectToUpdate instVarNamed: 'thirdInternalCollaborator' ) equals: 30
]

{ #category : #tests }
ObjectSynchronizerTest >> test04SynchronizingInternalCollaboratorsExceptACollection [

	| dummyObjectToUpdate updatedDummyObject |

	dummyObjectToUpdate := dummyObjectClass
		firstInternalCollaborator: 1
		secondInternalCollaborator: 2
		thirdInternalCollaborator: 3.

	updatedDummyObject := dummyObjectClass
		firstInternalCollaborator: 10
		secondInternalCollaborator: 20
		thirdInternalCollaborator: 30.

	( ObjectSynchronizer
		synchronizingInternalCollaboratorsFrom: dummyObjectToUpdate
		withThoseFrom: updatedDummyObject
		exceptAll: ( Array with: 'firstInternalCollaborator' with: 'thirdInternalCollaborator' ) )
		synchronize.

	self
		assert: ( dummyObjectToUpdate instVarNamed: 'firstInternalCollaborator' ) equals: 1;
		assert: ( dummyObjectToUpdate instVarNamed: 'secondInternalCollaborator' ) equals: 20;
		assert: ( dummyObjectToUpdate instVarNamed: 'thirdInternalCollaborator' ) equals: 3
]
