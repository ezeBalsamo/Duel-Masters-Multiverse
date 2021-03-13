Extension { #name : #DAPackageRelationGraphTest }

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions-Tests' }
DAPackageRelationGraphTest class >> defaultTimeLimit [

	^ 3 minutes
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions-Tests' }
DAPackageRelationGraphTest >> testAddClassesReferenceDependencies [

	self assert: packageRegexCore dependentPackages isEmpty.

	aPackageRelationGraph addReferenceDependencies: packageRegexCore.
	packageRegexCore removeAllInternal.

	self deny: ( packageRegexCore dependencies select: #isReferenceDependency ) isEmpty
]

{ #category : #'*DM-Tool-DependencyAnalyser-Core-Extensions-Tests' }
DAPackageRelationGraphTest >> testAddMessageSendReferenceDependencies [

	self assert: packageRegexCore dependentPackages isEmpty.

	aPackageRelationGraph addReferenceDependencies: packageRegexCore.
	packageRegexCore removeAllInternal.

	self deny: ( packageRegexCore dependencies select: #isMessageSendReferenceDependency ) isEmpty
]
