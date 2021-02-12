Trait {
	#name : #PersistentObjectBehaviour,
	#instVars : [
		'sequentialNumber'
	],
	#category : #'DM-Tools'
}

{ #category : #comparing }
PersistentObjectBehaviour >> = anObject [

	^ PersistentObjectComparer new shouldConsider: self asEqualTo: anObject
]

{ #category : #comparing }
PersistentObjectBehaviour >> hash [ 

	^ PersistentObjectComparer new hashFor: self
]

{ #category : #'private - accessing' }
PersistentObjectBehaviour >> internalCollaboratorsToAvoidSynchronizing [

	^ #()
]

{ #category : #'private - accessing' }
PersistentObjectBehaviour >> sequentialNumber [

	^sequentialNumber
]

{ #category : #updating }
PersistentObjectBehaviour >> synchronizeWith: anUpdatedDomainObject [

	( ObjectSynchronizer
		synchronizingInternalCollaboratorsFrom: self
		withThoseFrom: anUpdatedDomainObject
		exceptAll: self internalCollaboratorsToAvoidSynchronizing ) synchronize
]
