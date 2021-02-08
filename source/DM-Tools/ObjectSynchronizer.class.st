Class {
	#name : #ObjectSynchronizer,
	#superclass : #Object,
	#instVars : [
		'domainObjectToUpdate',
		'updatedDomainObject',
		'internalCollaboratorsToAvoidSinchronizing'
	],
	#category : #'DM-Tools'
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
		exceptAll: {#sequentialNumber}
]

{ #category : #'instance creation' }
ObjectSynchronizer class >> synchronizingInternalCollaboratorsFrom: aDomainObject
	withThoseFrom: anUpdatedDomainObject
	except: anInternalCollaboratorToAvoidSinchronizing [


	^ self
		synchronizingInternalCollaboratorsFrom: aDomainObject
		withThoseFrom: anUpdatedDomainObject
		exceptAll: {anInternalCollaboratorToAvoidSinchronizing}
]

{ #category : #'instance creation' }
ObjectSynchronizer class >> synchronizingInternalCollaboratorsFrom: aDomainObject
	withThoseFrom: anUpdatedDomainObject
	exceptAll: anInternalCollaboratorCollectionToAvoidSinchronizing [


	self assert: aDomainObject isFromTheSameClassThan: anUpdatedDomainObject.

	^ self new
		initializeSynchronizingInternalCollaboratorsFrom: aDomainObject
		withThoseFrom: anUpdatedDomainObject
		exceptAll: anInternalCollaboratorCollectionToAvoidSinchronizing
]

{ #category : #initialization }
ObjectSynchronizer >> initializeSynchronizingInternalCollaboratorsFrom: aDomainObject
	withThoseFrom: anUpdatedDomainObject
	exceptAll: anInternalCollaboratorCollectionToAvoidSinchronizing [


	domainObjectToUpdate := aDomainObject.
	updatedDomainObject := anUpdatedDomainObject.
	internalCollaboratorsToAvoidSinchronizing := anInternalCollaboratorCollectionToAvoidSinchronizing
]

{ #category : #'private - accessing' }
ObjectSynchronizer >> internalCollaboratorsToUpdate [

	^ domainObjectToUpdate class instVarNames copyWithoutAll: internalCollaboratorsToAvoidSinchronizing
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
