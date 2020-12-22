Class {
	#name : #UnnamedWikitextArgumentParser,
	#superclass : #WikitextArgumentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #parsing }
UnnamedWikitextArgumentParser >> parse [

	^ WikitextArgument unnamedWithContent: self parseContent
]

{ #category : #parsing }
UnnamedWikitextArgumentParser >> parseContent [

	self subclassResponsibility
]
