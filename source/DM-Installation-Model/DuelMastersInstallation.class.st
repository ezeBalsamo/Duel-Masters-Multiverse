Class {
	#name : #DuelMastersInstallation,
	#superclass : #SystemInstallation,
	#instVars : [
		'repositoryProviderModuleClass'
	],
	#category : #'DM-Installation-Model'
}

{ #category : #'instance creation' }
DuelMastersInstallation class >> providingInMemoryRepositories [

	^ self providingRepositoriesWith: InMemoryRepositoryProviderModule
]

{ #category : #'instance creation' }
DuelMastersInstallation class >> providingRepositoriesWith: aRepositoryProviderModuleClass [

	^ self new initializeProvidingRepositoriesWith: aRepositoryProviderModuleClass
]

{ #category : #installing }
DuelMastersInstallation >> beAwareOfShutDownOf: aCompositeSystem [

	"do nothing.- ebalsamo"

	
]

{ #category : #initialization }
DuelMastersInstallation >> initializeProvidingRepositoriesWith: aRepositoryProviderModuleClass [

	repositoryProviderModuleClass := aRepositoryProviderModuleClass
]

{ #category : #installing }
DuelMastersInstallation >> install [

	^ self install: 'No version'
]

{ #category : #accessing }
DuelMastersInstallation >> modulesToInstall [

	^ Array with: repositoryProviderModuleClass with: CardModule
]

{ #category : #accessing }
DuelMastersInstallation >> name [

	^'Duel Masters'
]
