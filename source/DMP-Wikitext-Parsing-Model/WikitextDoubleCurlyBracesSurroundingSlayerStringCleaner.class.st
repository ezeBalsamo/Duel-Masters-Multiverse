Class {
	#name : #WikitextDoubleCurlyBracesSurroundingSlayerStringCleaner,
	#superclass : #WikitextCleaner,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #cleaning }
WikitextDoubleCurlyBracesSurroundingSlayerStringCleaner >> clean: aWikitextToClean [

	^ aWikitextToClean copyReplaceAll: '"{{Slayer|no}}"' with: 'Slayer'
]
