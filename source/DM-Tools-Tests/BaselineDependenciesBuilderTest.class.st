"
A BaselineDependenciesBuilderTest is a test class for testing the behavior of BaselineDependenciesBuilder
"
Class {
	#name : #BaselineDependenciesBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'metacelloBaselineConstructor'
	],
	#category : #'DM-Tools-Tests'
}

{ #category : #'private - asserting' }
BaselineDependenciesBuilderTest >> assertTheOnlyOneProjectConfiguredInBaselineIs: aPotentialBaselineName [

	self
		withTheOnlyOneIn: self projectReferenceSpecifications
		do: [ :projectReferenceSpec | self assert: projectReferenceSpec name equals: aPotentialBaselineName ]
]

{ #category : #'private - asserting' }
BaselineDependenciesBuilderTest >> assertTheOnlyOneRepositoryHosting: aMetacelloProjectReferenceSpec is: aPotentialRepositoryAsString [

	self
		withTheOnlyOneIn: ( self repositoriesSpecificationsIn: aMetacelloProjectReferenceSpec )
		do: [ :repositorySpec | self assert: repositorySpec description equals: aPotentialRepositoryAsString ]
]

{ #category : #'private - accessing' }
BaselineDependenciesBuilderTest >> packages [

	^ metacelloBaselineConstructor root packages
]

{ #category : #'private - accessing' }
BaselineDependenciesBuilderTest >> projectReferenceSpecifications [

	^ self packages map values
]

{ #category : #'private - accessing' }
BaselineDependenciesBuilderTest >> repositoriesSpecificationsIn: aMetacelloProjectReferenceSpec [

	^ aMetacelloProjectReferenceSpec repositories map values
]

{ #category : #running }
BaselineDependenciesBuilderTest >> setUp [

	metacelloBaselineConstructor := MetacelloBaselineConstructor new.
	metacelloBaselineConstructor
		root: ( MetacelloCypressBaselineProject new projectAttributes: #() ) versionSpec
]

{ #category : #tests }
BaselineDependenciesBuilderTest >> test01ConfiguringOneDependencyLoadingOneGroup [

	| dependenciesBuilder |

	dependenciesBuilder := BaselineDependenciesBuilder
		configuringDependenciesOn: metacelloBaselineConstructor.

	dependenciesBuilder
		configureDependencyTo: #MyBaseline
		hostedIn: #MyGitRepository
		loading: #MyFirstGroup.

	self assertTheOnlyOneProjectConfiguredInBaselineIs: #MyBaseline.

	self
		withProjectReferenceNamed: #MyBaseline
		do: [ :projectReference | 
			self
				assertTheOnlyOneRepositoryHosting: projectReference is: #MyGitRepository;
				assertTheOnlyOneIn: projectReference loads is: #MyFirstGroup
			]
]

{ #category : #'private - accessing' }
BaselineDependenciesBuilderTest >> withProjectReferenceNamed: aBaselineName do: aBlock [

	| metacelloProjectReferenceSpec |

	metacelloProjectReferenceSpec := self packages
		detect: [ :projectReferenceSpec | projectReferenceSpec name = aBaselineName ]
		ifNone: [ self fail ].

	aBlock value: metacelloProjectReferenceSpec projectReference
]
