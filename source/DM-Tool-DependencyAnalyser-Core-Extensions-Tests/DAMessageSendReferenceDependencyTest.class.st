"
A DAMessageSendReferenceDependencyTest is a test class for testing the behavior of DAMessageSendReferenceDependency
"
Class {
	#name : #DAMessageSendReferenceDependencyTest,
	#superclass : #TestCase,
	#category : #'DM-Tool-DependencyAnalyser-Core-Extensions-Tests'
}

{ #category : #'private - accessing' }
DAMessageSendReferenceDependencyTest >> methodDefinitionFor: aSelector implementedIn: aPackageName [

	^ aSelector implementors
		detect: [ :aRGMethodDefinition | aRGMethodDefinition package name = aPackageName ]
]

{ #category : #tests }
DAMessageSendReferenceDependencyTest >> test01InstanceCreationAndAccessing [

	| sourcePackageName sourceDAPackage targetDAPackage selector rgMethodDefinition dependency |

	sourcePackageName := 'Collections-Abstract'.
	sourceDAPackage := DAPackage onPackageNamed: sourcePackageName.
	targetDAPackage := DAPackage onPackageNamed: 'Kernel'.
	selector := #yourself.
	rgMethodDefinition := self methodDefinitionFor: #with: implementedIn: sourcePackageName.

	dependency := DAMessageSendReferenceDependency
		from: sourceDAPackage
		to: targetDAPackage
		dueToSendOf: selector
		in: rgMethodDefinition.

	self
		assert: dependency method equals: rgMethodDefinition;
		assert: dependency methodClass equals: rgMethodDefinition methodClass;
		assert: dependency methodPrintString equals: rgMethodDefinition printString;
		assert: dependency nodeClass equals: DAExtensionDependencyNode;
		assert: dependency referenceSelector equals: selector;
		assert: dependency selector equals: rgMethodDefinition selector;
		assert: dependency printString
			equals: ( '<1p> sends <2p>' expandMacrosWith: rgMethodDefinition with: selector )
]
