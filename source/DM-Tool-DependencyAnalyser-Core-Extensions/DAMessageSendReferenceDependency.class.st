"
A DAMessageSendReferenceDependency is a reference dependency between two packages. 

Instance Variables
	selector:		the selector that references the message send
	method : 		the CompiledMethod

"
Class {
	#name : #DAMessageSendReferenceDependency,
	#superclass : #DADependencyFromClass,
	#instVars : [
		'method',
		'referenceSelector'
	],
	#category : #'DM-Tool-DependencyAnalyser-Core-Extensions'
}

{ #category : #'instance creation' }
DAMessageSendReferenceDependency class >> from: aSourceDAPackage to: aTargetDAPackage dueToSendOf: aSelector in: aRGMethodDefinition [

	^ self new
		initializeFrom: aSourceDAPackage
		to: aTargetDAPackage
		dueToSendOf: aSelector
		in: aRGMethodDefinition
]

{ #category : #initialization }
DAMessageSendReferenceDependency >> initializeFrom: aSourceDAPackage to: aTargetDAPackage dueToSendOf: aSelector in: aRGMethodDefinition [

	self
		initializeFrom: aSourceDAPackage to: aTargetDAPackage;
		theClass: aRGMethodDefinition methodClass.
	referenceSelector := aSelector.
	method := aRGMethodDefinition
]

{ #category : #accessing }
DAMessageSendReferenceDependency >> method [

	^ method
]

{ #category : #accessing }
DAMessageSendReferenceDependency >> methodClass [

	^ method methodClass
]

{ #category : #'private - accessing' }
DAMessageSendReferenceDependency >> methodPrintString [

	^ self method printString
]

{ #category : #accessing }
DAMessageSendReferenceDependency >> nodeClass [

	^ DAExtensionDependencyNode
]

{ #category : #printing }
DAMessageSendReferenceDependency >> printReasonOn: aStream [

	aStream
		nextPutAll: self methodPrintString;
		nextPutAll: ' sends ';
		print: self referenceSelector
]

{ #category : #accessing }
DAMessageSendReferenceDependency >> referenceSelector [

	^ referenceSelector
]

{ #category : #accessing }
DAMessageSendReferenceDependency >> selector [

	^ method selector
]
