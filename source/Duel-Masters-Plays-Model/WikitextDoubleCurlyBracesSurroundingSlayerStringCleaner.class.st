Class {
	#name : #WikitextDoubleCurlyBracesSurroundingSlayerStringCleaner,
	#superclass : #WikitextCleaner,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #cleaning }
WikitextDoubleCurlyBracesSurroundingSlayerStringCleaner >> clean: aWikitextToClean [

	^ aWikitextToClean copyReplaceAll: '"{{Slayer|no}}"' with: 'Slayer'
]
