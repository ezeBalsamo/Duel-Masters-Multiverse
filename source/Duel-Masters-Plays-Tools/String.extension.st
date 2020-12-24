Extension { #name : #String }

{ #category : #'*Duel-Masters-Plays-Tools' }
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

{ #category : #'*Duel-Masters-Plays-Tools' }
String >> findLastOccurrenceOfString: substring startingAt: start [ 
	"Answer the index of the last occurrence of substring within the receiver, starting at start. If 
	the receiver does not contain substring, answer 0.  Case-sensitive match used."

	| last now |
	last := self findString: substring startingAt: start.
	last = 0 ifTrue: [^ 0].
	[last > 0] whileTrue:
		[now := last.
		last := self findString: substring startingAt: last + 1].

	^ now

]

{ #category : #'*Duel-Masters-Plays-Tools' }
String >> ocurrencesQuantityOf: aDelimitor [

	^ ( self splitOn: aDelimitor ) size - 1
]
