Class {
	#name : #WikitextConfigurableCleaner,
	#superclass : #WikitextCleaner,
	#instVars : [
		'cleaners'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #cleaning }
WikitextConfigurableCleaner >> clean: aWikitextToClean [

	^ cleaners
		inject: aWikitextToClean
		into:
			[ :wikitextBeingCleaned :cleaner | cleaner clean: wikitextBeingCleaned ]
]

{ #category : #configuring }
WikitextConfigurableCleaner >> configureBlackSquareCleaner [

	cleaners add: WikitextBlackSquareCleaner new
]

{ #category : #configuring }
WikitextConfigurableCleaner >> configureBrTagsCleaner [

	cleaners add: WikitextBrTagsCleaner new
]

{ #category : #configuring }
WikitextConfigurableCleaner >> configureDoubleCurlyBracesSurroundingSearchStringCleaner [

	cleaners add: WikitextDoubleCurlyBracesSurroundingSearchStringCleaner new
]

{ #category : #configuring }
WikitextConfigurableCleaner >> configureDoubleCurlyBracesSurroundingSlayerStringCleaner [

	cleaners add: WikitextDoubleCurlyBracesSurroundingSlayerStringCleaner new
]

{ #category : #configuring }
WikitextConfigurableCleaner >> configureDoubleSquareBracesCleaner [

	cleaners add: WikitextDoubleSquareBracesCleaner new
]

{ #category : #configuring }
WikitextConfigurableCleaner >> configureWhiteSpacesCleaner [

	cleaners add: WikitextWhiteSpacesCleaner new
]

{ #category : #initialization }
WikitextConfigurableCleaner >> initialize [

	cleaners := OrderedCollection new
]
