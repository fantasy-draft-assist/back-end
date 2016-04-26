# Fantasy Draft Assist

Initial setup, fill this in more later

## General Rules

Heroku Site: hockeydoctor.herokuapp.com

### Authorization

All authorized requests unless otherwise mentioned require an "**Internal_Auth**" header to be present. Users are assigned an Auth Token during account creation.

### Errors

Any request that fails to be processed will contain an "errors" key in the returned JSON describing the problem.

## Routes

#### POST /registration

*This route is for managing registration of new users.*

Params:
* username: string
* email: string
* password: string

Returns 201 Created on Success and 422 Unprocessable Entity in case of failure.

**Request**
```
{
	"username": "Bob",
	"email:" "Bob@bob.bob",
	"password": "password"
}
```

**Response**
```
{
	"user": {
		"username": "bob",
		"email": "bob@bob.bob",
		"auth_token": "c92692fd6c686ef6985b8eb124d37488"
	}
}
```

#### POST /login

*This route is for logging in created users.*

Params:
* username:string

Returns 200 OK on Success and 401 Unauthorized in case of failure.

**Request**
```
{
	"username": "Bob"
}
```

#### DELETE /registration

*This route is for deleting users.*

Params:
* username:string

Returns 202 Accepted on Success and 401 Unauthorized in case of failure.

**Request**
```
{
	"username": "Bob"
}
```