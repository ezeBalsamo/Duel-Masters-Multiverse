"
A DuelistTest is a test class for testing the behavior of Duelist
"
Class {
	#name : #DuelistTest,
	#superclass : #TestCase,
	#category : #'DM-Match-Model-Tests'
}

{ #category : #'private - accessing' }
DuelistTest >> deck [

	^ #()
]

{ #category : #tests }
DuelistTest >> test01DuelistMustHaveName [

	| deck |

	deck := self deck.
	self
		should: [ Duelist named: '' using: deck ]
		raise: InstanceCreationFailed
		withMessageText: 'A duelist must have a name.'
]

{ #category : #tests }
DuelistTest >> test02InstanceCreationAndAccessing [

	| name deck duelist |

	name := 'Shobu'.
	deck := self deck.

	duelist := Duelist named: name using: deck.

	self
		assert: duelist name equals: name;
		assert: duelist deck equals: deck
]

{ #category : #tests }
DuelistTest >> test03PrintString [

	| name deck duelist |

	name := 'Shobu'.
	deck := self deck.

	duelist := Duelist named: name using: deck.

	self assert: duelist asString equals: name
]
