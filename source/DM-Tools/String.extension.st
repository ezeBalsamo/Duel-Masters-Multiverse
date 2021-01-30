Extension { #name : #String }

{ #category : #'*DM-Tools' }
String class >> blackSquare [

	^ self with: Character blackSquare
]

{ #category : #'*DM-Tools' }
String >> detect: aClosingCharacter closeTo: anOpeningCharacter startingAt: anStartIndex ifFound: aFoundBlock ifNone: aNotFoundBlock [

	| index nestLevel |

	index := anStartIndex + 1.
	nestLevel := 1.

	index to: self size do: [ :currentIndex | 
		( self at: currentIndex ) = anOpeningCharacter
			ifTrue: [ nestLevel := nestLevel + 1 ].
		( self at: currentIndex ) = aClosingCharacter
			ifTrue: [ nestLevel := nestLevel - 1 ].
		nestLevel isZero
			ifTrue: [ ^ aFoundBlock value: currentIndex ]
		].

	^ aNotFoundBlock value
]

{ #category : #'*DM-Tools' }
String >> occurrencesQuantityOf: aDelimitor [

	^ ( self splitOn: aDelimitor ) size - 1
]

{ #category : #'*DM-Tools' }
String >> splitOnFirstOccurrenceOf: aStringOrCharacterDelimitor ifNone: aNoneBlock [

	| delimitorIndex |

	delimitorIndex := aStringOrCharacterDelimitor isCharacter
		ifTrue: [ self indexOf: aStringOrCharacterDelimitor ]
		ifFalse: [ aStringOrCharacterDelimitor isString
				ifTrue: [ self findString: aStringOrCharacterDelimitor ]
				ifFalse: [ Error signal: 'string or character as delimitor expected' ]
			].

	^ delimitorIndex isZero
		ifTrue: aNoneBlock
		ifFalse: [ Array
				with: ( self first: delimitorIndex - 1 )
				with: ( self allButFirst: delimitorIndex )
			]
]
