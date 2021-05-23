Class {
	#name : #SystemInterfaceIntegrityTest,
	#superclass : #DevelopmentTest,
	#pools : [
		'Kepler'
	],
	#category : #'DM-Development-Support-Tests'
}

{ #category : #'private - accessing' }
SystemInterfaceIntegrityTest >> allImplementedInterfacesSelectorsOf: aSystemImplementationClass [

	^ aSystemImplementationClass new implementedInterfaces
		inject: OrderedCollection new
		into: [ :selectors :interfaceKey | 
			selectors
				addAll: ( SystemInterfaces >> interfaceKey ) interfaceSelectors;
				yourself
			]
]

{ #category : #'private - asserting' }
SystemInterfaceIntegrityTest >> assert: aSystemImplementationClass implementsAllSelectorsRequiredByItsDeclaredInterfacesLoggingFailuresOn: aStream [

	| system |

	system := aSystemImplementationClass new.

	system implementedInterfaces
		reject: [ :aSystemInterfaceKey | SystemInterfaces >> aSystemInterfaceKey isImplementedBy: system ]
		thenDo: [ :aSystemInterfaceKey | 
			self
				log:
					( '<1p> declares <2s> but does not implement all its required protocol.'
						expandMacrosWith: aSystemImplementationClass
						with: aSystemInterfaceKey )
				on: aStream
			]
]

{ #category : #'private - asserting' }
SystemInterfaceIntegrityTest >> assertPublicProtocolOf: aSystemImplementationClass
	isDefinedByItsDeclaredInterfacesLoggingFailuresOn: aStream [


	| expectedInterfacesSelectors interfacesSelectors notDeclaredSelectors |

	expectedInterfacesSelectors := self expectedInterfacesSelectorsOf: aSystemImplementationClass.
	interfacesSelectors := self allImplementedInterfacesSelectorsOf: aSystemImplementationClass.

	notDeclaredSelectors := expectedInterfacesSelectors difference: interfacesSelectors.

	notDeclaredSelectors
		ifNotEmpty: [ self
				log: notDeclaredSelectors
				asNotDeclaredByAnyOfTheDeclaredInterfacesOf: aSystemImplementationClass
				on: aStream
			]
]

{ #category : #'private - accessing' }
SystemInterfaceIntegrityTest >> expectedInterfacesSelectorsOf: aSystemImplementationClass [

	^ ( self publicSelectorsOf: aSystemImplementationClass )
		reject: [ :aSelector | self systemImplementionPublicSelectors includes: aSelector ]
]

{ #category : #'private - logging' }
SystemInterfaceIntegrityTest >> log: aSelectorsCollection asNotDeclaredByAnyOfTheDeclaredInterfacesOf: aSystemImplementationClass on: aStream [

	| formattedSelectors |

	formattedSelectors := ( CollectionFormatter separatingWith: ', ' ) format: aSelectorsCollection.

	self
		log:
			( '<1p> has methods not declared by any of its interfaces: (<2s>)'
				expandMacrosWith: aSystemImplementationClass
				with: formattedSelectors )
		on: aStream
]

{ #category : #'private - accessing' }
SystemInterfaceIntegrityTest >> ownedSubsystemImplementationSubclasses [

	| ownedSubsystemClasses |

	ownedSubsystemClasses := SubsystemImplementation allSubclasses
		select: [ :aClass | self ownedClasses includes: aClass ].

	^ ownedSubsystemClasses
		add: RepositoryProviderSystem;
		yourself
]

{ #category : #'private - accessing' }
SystemInterfaceIntegrityTest >> publicSelectorsOf: aClass [

	^ aClass methods
		reject: [ :aCompiledMethod | 
			( aCompiledMethod selector beginsWith: 'initialize' )
				or: [ aCompiledMethod protocol beginsWith: 'private' ]
			]
		thenCollect: #selector
]

{ #category : #'private - accessing' }
SystemInterfaceIntegrityTest >> systemImplementionPublicSelectors [

	^ #(name implementedInterfaces dependencies resolveDependencies)
]

{ #category : #tests }
SystemInterfaceIntegrityTest >> test01SystemImplementationsComplyToTheirDeclaredInterfaces [

	self
		runLoggingFailuresOn: [ :aStream | 
			SubsystemImplementation subclasses
				do: [ :aSystemImplementationClass | 
					self
						assert: aSystemImplementationClass
						implementsAllSelectorsRequiredByItsDeclaredInterfacesLoggingFailuresOn: aStream
					]
			]
]

{ #category : #tests }
SystemInterfaceIntegrityTest >> test02SystemImplementationsProtocolIsDeterminedByTheirDeclaredInterfaces [

	self
		runLoggingFailuresOn: [ :aStream | 
			self ownedSubsystemImplementationSubclasses
				do: [ :aSystemImplementationClass | 
					self
						assertPublicProtocolOf: aSystemImplementationClass
						isDefinedByItsDeclaredInterfacesLoggingFailuresOn: aStream
					]
			]
]
