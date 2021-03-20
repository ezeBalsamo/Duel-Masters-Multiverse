"
A RDBSystemBasedUserStoryTestSuiteBuilderTest is a test class for testing the behavior of RDBSystemBasedUserStoryTestSuiteBuilder
"
Class {
	#name : #RDBSystemBasedUserStoryTestSuiteBuilderTest,
	#superclass : #TestCase,
	#category : #'DM-Development-Support-Tests'
}

{ #category : #tests }
RDBSystemBasedUserStoryTestSuiteBuilderTest >> test01BuildingSuiteForAPersistentSystemBasedUserStoryTestSubclass [

	| testClass rdbTestSuite |

	testClass := CivilizationManagementSystemUserStoryTest.

	rdbTestSuite := RDBSystemBasedUserStoryTestSuiteBuilder for: testClass.

	self assert: ( rdbTestSuite allTests allSatisfy: #isUsingRelationalDatabaseRepositories )
]

{ #category : #tests }
RDBSystemBasedUserStoryTestSuiteBuilderTest >> test02CantBuildSuiteForANonPersistentSystemBasedUserStoryTestSubclass [

	| testClass |

	testClass := PackageIntegrityTest.

	self
		should: [ RDBSystemBasedUserStoryTestSuiteBuilder for: PackageIntegrityTest ]
		raise: ProgrammingError
		withMessageText:
			( '<1p> must be <2p> subclass.' expandMacrosWith: testClass with: PersistentSystemBasedUserStoryTest )
]

{ #category : #tests }
RDBSystemBasedUserStoryTestSuiteBuilderTest >> test03BuildingSuiteForAllPersistentSystemUserStoryTests [

	| testClass rdbSuite rdbSuiteTests expectedTests |

	testClass := PersistentSystemBasedUserStoryTest.
	rdbSuite := RDBSystemBasedUserStoryTestSuiteBuilder suite.
	rdbSuiteTests := rdbSuite allTests.

	expectedTests := testClass suite allTests.

	self
		assert: ( expectedTests noneSatisfy: #isUsingRelationalDatabaseRepositories );
		assert: rdbSuite name equals: testClass name;
		assert: ( rdbSuiteTests allSatisfy: #isUsingRelationalDatabaseRepositories );
		assert: rdbSuiteTests
			hasEquivalentElementsThan: expectedTests
			comparingWith: [ :anInMemoryTest :anRDBTest | anInMemoryTest asString = anRDBTest asString ]
]
