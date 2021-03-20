Class {
	#name : #RDBSystemBasedUserStoryTestSuiteBuilder,
	#superclass : #Object,
	#category : #'DM-Development-Support'
}

{ #category : #'private - asserting' }
RDBSystemBasedUserStoryTestSuiteBuilder class >> assertIsPersistent: aPotentiallyPersistentTest [

	| persistentClass |

	persistentClass := PersistentSystemBasedUserStoryTest.

	AssertionChecker
		enforce: [ aPotentiallyPersistentTest includesBehavior: persistentClass ]
		because: ( '<1p> must be <2p> subclass.' expandMacrosWith: aPotentiallyPersistentTest with: persistentClass )
		raising: ProgrammingError
]

{ #category : #'private - building' }
RDBSystemBasedUserStoryTestSuiteBuilder class >> for: aPotentiallyPersistentSystemBasedUserStoryTest [

	self assertIsPersistent: aPotentiallyPersistentSystemBasedUserStoryTest.
	^ aPotentiallyPersistentSystemBasedUserStoryTest buildRDBSuiteForCI
]

{ #category : #'private - building' }
RDBSystemBasedUserStoryTestSuiteBuilder class >> forAllPersistentUserStoryTests [

	^ self for: PersistentSystemBasedUserStoryTest
]

{ #category : #'instance creation' }
RDBSystemBasedUserStoryTestSuiteBuilder class >> suite [

	^ self forAllPersistentUserStoryTests
]
