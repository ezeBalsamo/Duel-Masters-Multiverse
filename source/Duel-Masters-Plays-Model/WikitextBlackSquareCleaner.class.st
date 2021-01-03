Class {
	#name : #WikitextBlackSquareCleaner,
	#superclass : #WikitextCleaner,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #cleaning }
WikitextBlackSquareCleaner >> clean: aWikitextToClean [

	^ aWikitextToClean withoutPrefix: Character blackSquare asString
]
