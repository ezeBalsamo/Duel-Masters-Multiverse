Class {
	#name : #CardModule,
	#superclass : #SystemModule,
	#instVars : [
		'rootSystem'
	],
	#category : #'DM-Card-Module-Model'
}

{ #category : #'instance creation' }
CardModule class >> toInstallOn: aCompositeSystem [

	^ self new initializeToInstallOn: aCompositeSystem
]

{ #category : #initialization }
CardModule >> initializeToInstallOn: aCompositeSystem [

	rootSystem := aCompositeSystem
]

{ #category : #private }
CardModule >> name [

	^ 'Cards Management'
]

{ #category : #private }
CardModule >> rootSystem [

	^ rootSystem
]

{ #category : #private }
CardModule >> systemInterfacesToInstall [

	^ #(#CivilizationManagementSystemInterface #RaceManagementSystemInterface #CardManagementSystemInterface)
]
