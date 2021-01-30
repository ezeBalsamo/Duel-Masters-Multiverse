Class {
	#name : #DuelMastersInstallation,
	#superclass : #SystemInstallation,
	#category : #'DM-Installation-Model'
}

{ #category : #installing }
DuelMastersInstallation >> beAwareOfShutDownOf: aCompositeSystem [

	"do nothing.- ebalsamo"

	
]

{ #category : #installing }
DuelMastersInstallation >> install [

	^ self install: 'No version'
]

{ #category : #accessing }
DuelMastersInstallation >> modulesToInstall [

	^ Array with: CardModule
]

{ #category : #accessing }
DuelMastersInstallation >> name [

	^'Duel Masters'
]
