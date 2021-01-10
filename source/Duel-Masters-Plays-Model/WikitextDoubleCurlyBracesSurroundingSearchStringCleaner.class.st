Class {
	#name : #WikitextDoubleCurlyBracesSurroundingSearchStringCleaner,
	#superclass : #WikitextCleaner,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #cleaning }
WikitextDoubleCurlyBracesSurroundingSearchStringCleaner >> clean: aWikitextToClean [

	^ ( aWikitextToClean copyReplaceAll: '{{search}}' with: 'search' )
		copyReplaceAll: '{{Search|cap}}'
		with: 'Search'
]
