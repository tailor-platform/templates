package manifest

#UUID:       =~"^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
#PortNumber: >=0 & <=65535
#MongoURI:   =~"^mongodb:\/\/"

#Organization: {
	id:    #UUID
	name:  string
}

#Database: {
	name:     string | *"minitailor"
	username: string | *"minitailor_user"
	password: string | *"password"
	hostname: string | *"localhost"
	port:     #PortNumber | *35432
}

#Mongo: {
	uri: #MongoURI | *"mongodb://localhost:27017"
}

#Pubsub: {
	host: string | *"localhost"
	port: #PortNumber | *28085
}

#Minitailor: {
	port:         #PortNumber | *8000
	organization: #Organization
	database:     #Database
	mongo:        #Mongo
	pubsub:       #Pubsub
}
