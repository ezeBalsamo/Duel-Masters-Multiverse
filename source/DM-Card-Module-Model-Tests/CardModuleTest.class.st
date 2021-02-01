"
A CardModuleTest is a test class for testing the behavior of CardModule
"
Class {
	#name : #CardModuleTest,
	#superclass : #ModuleTest,
	#category : #'DM-Card-Module-Model-Tests'
}

{ #category : #'private - accessing' }
CardModuleTest >> moduleClass [

	^ CardModule
]

{ #category : #'private - accessing' }
CardModuleTest >> moduleName [

	^ 'Cards Management'
]

{ #category : #'private - accessing' }
CardModuleTest >> systemInterfacesToInstall [

	^ #(#CivilizationManagementSystemInterface #RaceManagementSystemInterface #CardManagementSystemInterface)
]
