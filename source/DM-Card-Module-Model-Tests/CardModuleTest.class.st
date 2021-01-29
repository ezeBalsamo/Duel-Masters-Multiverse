"
A CardModuleTest is a test class for testing the behavior of CardModule
"
Class {
	#name : #CardModuleTest,
	#superclass : #TestCase,
	#instVars : [
		'rootSystem'
	],
	#category : #'DM-Card-Module-Model-Tests'
}

{ #category : #tests }
CardModuleTest >> setUp [

	rootSystem := CompositeSystem new
]

{ #category : #tests }
CardModuleTest >> test01Name [

	| cardModule |

	cardModule := CardModule toInstallOn: rootSystem.

	self assert: cardModule name equals: 'Cards Management'
]

{ #category : #tests }
CardModuleTest >> test02SystemInterfacesToInstall [

	| cardModule |

	cardModule := CardModule toInstallOn: rootSystem.

	self
		assert: cardModule systemInterfacesToInstall
		equals:
			#(#CivilizationManagementSystemInterface #RaceManagementSystemInterface #CardManagementSystemInterface)
]
