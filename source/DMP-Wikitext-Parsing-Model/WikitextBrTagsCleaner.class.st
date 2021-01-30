Class {
	#name : #WikitextBrTagsCleaner,
	#superclass : #WikitextCleaner,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #'private - accessing' }
WikitextBrTagsCleaner >> brTag [

	^ '<br>'
]

{ #category : #cleaning }
WikitextBrTagsCleaner >> clean: aWikitextToClean [

	| trimmedWikitextToClean brTag |

	trimmedWikitextToClean := WikitextWhiteSpacesCleaner new
		clean: aWikitextToClean.
	brTag := self brTag.
	^ ( trimmedWikitextToClean withoutPrefix: brTag )
		withoutSuffix: brTag
]
