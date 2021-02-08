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
PersistentObjectBehaviour >> sequentialNumber [

	^sequentialNumber
]

{ #category : #updating }
PersistentObjectBehaviour >> synchronizeWith: aSingleCivilization [

	( ObjectSynchronizer
		synchronizingInternalCollaboratorsFrom: self
		withThoseFrom: aSingleCivilization ) synchronize
]
