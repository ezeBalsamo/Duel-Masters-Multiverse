Extension { #name : #String }

{ #category : #'*Duel-Masters-Plays-Tools' }
String >> find: aClosingCharacter closeTo: anOpeningCharacter startingAt: anStartIndex [

	| index nestLevel |

	index := anStartIndex + 1.
	nestLevel := 1.
	index to: self size do: [ :currentIndex | 
		( self at: currentIndex ) = anOpeningCharacter
			ifTrue: [ nestLevel := nestLevel + 1 ].
		( self at: currentIndex ) = aClosingCharacter
			ifTrue: [ nestLevel := nestLevel - 1 ].
		nestLevel isZero
			ifTrue: [ ^ currentIndex ]
		].

	Error
		signal:
			( #'The arguments includes <1s> but not <2s>'
				expandMacrosWith: anOpeningCharacter
				with: aClosingCharacter )
]

{ #category : #'*Duel-Masters-Plays-Tools' }
String >> splitOnFirstOccurrenceOf: aStringOrCharacterDelimitor [

	| delimitorIndex |

	delimitorIndex := aStringOrCharacterDelimitor isCharacter
		ifTrue: [ self indexOf: aStringOrCharacterDelimitor ]
		ifFalse: [ aStringOrCharacterDelimitor isString
				ifTrue: [ self findString: aStringOrCharacterDelimitor ]
				ifFalse: [ Error signal: 'string or character as delimitor expected' ]
			].

	^ Array with: ( self first: delimitorIndex - 1 ) with: ( self allButFirst: delimitorIndex )
]
