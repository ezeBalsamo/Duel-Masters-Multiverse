Class {
	#name : #ObjectSynchronizer,
	#superclass : #Object,
	#instVars : [
		'domainObjectToUpdate',
		'updatedDomainObject',
		'internalCollaboratorsToAvoidSynchronizing'
	],
	#category : #'DM-Sagan-Extensions'
}

{ #category : #'private - preconditions' }
ObjectSynchronizer class >> assert: aDomainObject isFromTheSameClassThan: anUpdatedDomainObject [

	AssertionChecker
		enforce: [ aDomainObject isA: anUpdatedDomainObject class ]
		because:
			( 'An object of type <1s> can''t be synchronized with one of type <2s> because they are from different classes'
				expandMacrosWith: aDomainObject class printString
				with: anUpdatedDomainObject class printString )
]

{ #category : #'instance creation' }
ObjectSynchronizer class >> synchronizingInternalCollaboratorsFrom: aDomainObject withThoseFrom: anUpdatedDomainObject [

	^ self
		synchronizingInternalCollaboratorsFrom: aDomainObject
		withThoseFrom: anUpdatedDomainObject
		exceptAll: #()
]

{ #category : #'instance creation' }
ObjectSynchronizer class >> synchronizingInternalCollaboratorsFrom: aDomainObject
	withThoseFrom: anUpdatedDomainObject
	except: anInternalCollaboratorToAvoidSynchronizing [


	^ self
		synchronizingInternalCollaboratorsFrom: aDomainObject
		withThoseFrom: anUpdatedDomainObject
		exceptAll: {anInternalCollaboratorToAvoidSynchronizing}
]

{ #category : #'instance creation' }
ObjectSynchronizer class >> synchronizingInternalCollaboratorsFrom: aDomainObject
	withThoseFrom: anUpdatedDomainObject
	exceptAll: anInternalCollaboratorCollectionToAvoidSynchronizing [


	self assert: aDomainObject isFromTheSameClassThan: anUpdatedDomainObject.

	^ self new
		initializeSynchronizingInternalCollaboratorsFrom: aDomainObject
		withThoseFrom: anUpdatedDomainObject
		exceptAll:
			( anInternalCollaboratorCollectionToAvoidSynchronizing asOrderedCollection
				add: #sequentialNumber;
				yourself )
]

{ #category : #initialization }
ObjectSynchronizer >> initializeSynchronizingInternalCollaboratorsFrom: aDomainObject
	withThoseFrom: anUpdatedDomainObject
	exceptAll: anInternalCollaboratorCollectionToAvoidSynchronizing [


	domainObjectToUpdate := aDomainObject.
	updatedDomainObject := anUpdatedDomainObject.
	internalCollaboratorsToAvoidSynchronizing := anInternalCollaboratorCollectionToAvoidSynchronizing
]

{ #category : #'private - accessing' }
ObjectSynchronizer >> internalCollaboratorsToUpdate [

	^ domainObjectToUpdate class instVarNames copyWithoutAll: internalCollaboratorsToAvoidSynchronizing
]

{ #category : #synchronizing }
ObjectSynchronizer >> synchronize [

	self
		withInternalCollaboratorsToUpdateDo:
			[ :internalCollaboratorNameToUpdate | self synchronizeInternalCollaboratorNamed: internalCollaboratorNameToUpdate ]
]

{ #category : #'private - synchronizing' }
ObjectSynchronizer >> synchronizeInternalCollaboratorNamed: anInternalCollaboratorNameToUpdate [

	| updatedInternalCollaborator |

	updatedInternalCollaborator := updatedDomainObject perform: anInternalCollaboratorNameToUpdate.

	domainObjectToUpdate
		instVarNamed: anInternalCollaboratorNameToUpdate
		put: updatedInternalCollaborator
]

{ #category : #'private - accessing' }
ObjectSynchronizer >> withInternalCollaboratorsToUpdateDo: aBlock [

	self internalCollaboratorsToUpdate do: aBlock
]
