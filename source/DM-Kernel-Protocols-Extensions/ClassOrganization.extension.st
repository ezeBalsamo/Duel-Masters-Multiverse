Extension { #name : #ClassOrganization }

{ #category : #'*DM-Kernel-Protocols-Extensions' }
ClassOrganization >> emptyCategories [

	^ self protocolOrganizer emptyProtocols collect: #name
]
