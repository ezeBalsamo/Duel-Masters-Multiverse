Class {
	#name : #BaselineDependenciesBuilder,
	#superclass : #Object,
	#instVars : [
		'metacelloBaselineConstructor'
	],
	#category : #'DM-Tools'
}

{ #category : #'instance creation' }
BaselineDependenciesBuilder class >> configuringDependenciesOn: aMetacelloBaselineConstructor [

	^ self new initializeConfiguringDependenciesOn: aMetacelloBaselineConstructor
]

{ #category : #configuring }
BaselineDependenciesBuilder >> configureDependencyTo: aBaselineName hostedIn: aRepositoryAsString loading: aGroupName [

	self configureDependencyTo: aBaselineName hostedIn: aRepositoryAsString loadingAll: {aGroupName}
]

{ #category : #configuring }
BaselineDependenciesBuilder >> configureDependencyTo: aBaselineName hostedIn: aRepositoryAsString loadingAll: aGroupNameCollection [

	metacelloBaselineConstructor
		baseline: aBaselineName
		with: [ metacelloBaselineConstructor
				repository: aRepositoryAsString;
				loads: aGroupNameCollection
			]
]

{ #category : #initialization }
BaselineDependenciesBuilder >> initializeConfiguringDependenciesOn: aMetacelloBaselineConstructor [

	metacelloBaselineConstructor := aMetacelloBaselineConstructor
]
