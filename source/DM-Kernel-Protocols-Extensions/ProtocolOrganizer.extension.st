Extension { #name : #ProtocolOrganizer }

{ #category : #'*DM-Kernel-Protocols-Extensions' }
ProtocolOrganizer >> emptyProtocols [

	^ protocols select: #canBeRemoved
]
