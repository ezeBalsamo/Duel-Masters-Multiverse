Class {
	#name : #PostgreSQLLogin,
	#superclass : #Object,
	#category : #'DM-Sagan-Extensions'
}

{ #category : #accessing }
PostgreSQLLogin class >> toDatabaseNamed: aDatabaseName hostedIn: aHost onPort: aPortNumber authenticatedAs: anUsername with: aPassword [

	self useP3Driver.
	
	^ Login new
		database: PostgreSQLPlatform new;
		username: anUsername;
		password: aPassword ;
		host: aHost ;
		port: aPortNumber;
		databaseName: aDatabaseName;
		yourself
]

{ #category : #'private - configuring' }
PostgreSQLLogin class >> useP3Driver [

	DatabaseAccessor classForThisPlatform DefaultDriver: P3DatabaseDriver
]
