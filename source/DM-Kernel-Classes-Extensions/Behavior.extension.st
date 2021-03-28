Extension { #name : #Behavior }

{ #category : #'*DM-Kernel-Classes-Extensions' }
Behavior >> recompile: selector from: oldClass [

	"Compile the method associated with selector in the receiver's method dictionary."

	| method newMethod |

	method := oldClass compiledMethodAt: selector.
	newMethod := self compiler
		source: ( oldClass sourceCodeAt: selector );
		class: self;
		failBlock: [ ^ self ];
		compiledMethodTrailer: method trailer;
		compile.	"Assume OK after proceed from SyntaxError"
	selector == newMethod selector
		ifFalse: [ self
				error: ( '<1p> has changed after recompiling, so it''s bad compiled.' expandMacrosWith: newMethod )
			].
	self addSelectorSilently: selector withMethod: newMethod
]
