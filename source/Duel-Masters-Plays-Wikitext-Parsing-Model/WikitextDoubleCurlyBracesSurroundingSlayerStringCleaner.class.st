Class {
	#name : #WikitextDoubleCurlyBracesSurroundingSlayerStringCleaner,
	#superclass : #WikitextCleaner,
	#category : #'Duel-Masters-Plays-Wikitext-Parsing-Model'
}

{ #category : #cleaning }
WikitextDoubleCurlyBracesSurroundingSlayerStringCleaner >> clean: aWikitextToClean [

	^ aWikitextToClean copyReplaceAll: '"{{Slayer|no}}"' with: 'Slayer'
]
