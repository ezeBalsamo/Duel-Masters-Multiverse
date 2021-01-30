Class {
	#name : #ManifestKeplerCardsManagement,
	#superclass : #PackageManifest,
	#category : #'DM-Card-Management-System-Model-Manifest'
}

{ #category : #'class initialization' }
ManifestKeplerCardsManagement class >> initialize [

	<ignoreForCoverage>
	Kepler
		registerInterfaceAt: #CardManagementSystemInterface
		named: 'Card Management System Interface'
		declaring: #(#name)
]
