Class {
	#name : #ModuleTest,
	#superclass : #TestCase,
	#instVars : [
		'rootSystem'
	],
	#category : #'DM-Repository-Provider-Module-Model-Tests'
}

{ #category : #testing }
ModuleTest class >> isAbstract [

	^ self = ModuleTest
]

{ #category : #'private - asserting' }
ModuleTest >> assert: aSystemInterfaceKey wasInstalledBy: aModule using: installedModuleRegistrationSystem [

	| installedModule |

	installedModule := installedModuleRegistrationSystem
		installedModuleRegisteringSystemImplementing: aSystemInterfaceKey.
	self assert: ( aModule isEquivalentTo: installedModule )
]

{ #category : #'private - asserting' }
ModuleTest >> assertExistsSystemImplementing: aSystemInterfaceKey [

	rootSystem systemImplementing: aSystemInterfaceKey ifNone: [ self fail ]
]

{ #category : #'private - accessing' }
ModuleTest >> moduleClass [

	self subclassResponsibility
]

{ #category : #'private - accessing' }
ModuleTest >> moduleName [

	self subclassResponsibility
]

{ #category : #running }
ModuleTest >> setUp [

	rootSystem := CompositeSystem new
]

{ #category : #'private - accessing' }
ModuleTest >> systemInterfacesToInstall [

	self subclassResponsibility
]

{ #category : #tests }
ModuleTest >> test01Name [

	| module |

	module := self moduleClass toInstallOn: rootSystem.

	self assert: module name equals: self moduleName
]

{ #category : #tests }
ModuleTest >> test02SystemInterfacesToInstall [

	| module |

	module := self moduleClass toInstallOn: rootSystem.

	self assertCollection: module systemInterfacesToInstall equals: self systemInterfacesToInstall
]

{ #category : #tests }
ModuleTest >> test03ModuleInstallation [

	| module installedModuleRegistrationSystem |

	rootSystem register: InstalledModuleRegistrationSystem new.
	module := self moduleClass toInstallOn: rootSystem.
	module install.

	installedModuleRegistrationSystem := rootSystem >> #InstalledModuleRegistrationSystem.

	installedModuleRegistrationSystem ifNotRegisteredAsInstalled: module do: [ self fail ].

	self systemInterfacesToInstall
		do: [ :systemInterfaceKey | 
			self
				assertExistsSystemImplementing: systemInterfaceKey;
				assert: systemInterfaceKey wasInstalledBy: module using: installedModuleRegistrationSystem
			]
]
