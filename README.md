# Fantasy Draft Assist

Info

## General Rules

Heroku Site: hockeydoctor.herokuapp.com

### Authorization

All authorized requests unless otherwise mentioned require an "**Internal**" header to be present with the Auth Token set as the value. Users are assigned an Auth Token during account creation.

### Errors

Any request that fails to be processed will contain an "errors" key in the returned JSON describing the problem.

## Routes

#### POST /registration

*This route is for managing registration of new users.*

Params:
* username: string
* email: string
* password: string
* favorite_team: string
* league_name: string
* team_count: integer between 8 and 20
* player_count: integer between 1 and 20
* goalie_count: integer between 1 and 2

Returns 201 Created on Success and 422 Unprocessable Entity in case of failure.

**Request**
```
{
	"username": "notttyy",
	"email:" "not@not.nottttyy",
	"password": "password"
	"favorite_team": "Boston Bruins"
	"league_name": "Fire"
	"team_count": 8     
	"player_count": 20
	"goalie_count": 2
}
```

**Response**
```
{
  "user": {
    "username": "notttyy",
    "email": "not@not.nottttyy",
    "auth_token": "ff4efa0a19ffef89f2276e354085f80e",
    "favorite_team": "Boston Bruins"
  },
  "league": {
    "id": 6,
    "name": "Fire",
    "team_count": 8,
    "player_count": 20,
    "goalie_count": 2
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
	"username": "boston",
	"password": "bruins"
}
```

**Response**
```
{
	"user" {
		"id": 5,
		"username": "boston",
		"auth_token": "60e6cad67999b5127746026b7019fa99",
		"favorite_team": "Boston Bruins",
		"league": "fire"
	}
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

**Response**
```
	{
	"User Destroyed."
	}
```

#### PUT /settings

*this route is for updating league settings, use true or false for on or off*

Params:
* player_count: integer (between 1 and 23)
* goalie_count: integer (between 1 and 2)
* games_played: boolean
* goals: boolean
* assists: boolean
* points: boolean
* plus_minus: boolean
* penalty_minutes: boolean
* powerplay_goals: boolean
* powerplay_assists: boolean
* powerplay_points: boolean
* shorthanded_goals: boolean
* shorthanded_assists: boolean
* shorthanded_points: boolean
* game_winning_goals: boolean 
* shots_on_goal: boolean
* shot_percentage: boolean
* faceoffs_won: boolean
* faceoffs_lost: boolean
* games_started: boolean
* wins: boolean
* losses: boolean
* goals_against: boolean
* goals_against_average: boolean
* shots_against: boolean
* saves: boolean
* save_percentage: boolean
* shutouts: boolean
* minutes_played: boolean
* hits: boolean
* blocks: boolean

#### Routes to get One Player's Data
#### get players/one/:yahoo_player_id/

*this route is to get one player by yahoo player id, including stats and pro team information*

Params: 
yahoo_player_id: integer

**Request**

```
	../players/one/35
```

**Response**
```
{
  "player": {
    "id": 1,
    "first_name": "Jaromir",
    "last_name": "Jagr",
    "yahoo_player_id": 35,
    "headshot_url": "https://s.yimg.com/iu/api/res/1.2/txheDv37R7ZklMNvS.I6fw--/YXBwaWQ9c2hhcmVkO2NoPTIzMzY7Y3I9MTtjdz0xNzkwO2R4PTg1NztkeT0wO2ZpPXVsY3JvcDtoPTYwO3E9MTAwO3c9NDY-/https://s.yimg.com/xe/i/us/sp/v/nhl_cutout/players_l/20151021/35.png",
    "uniform_number": 68,
    "positions": [
      "RW"
    ],
    "created_at": "2016-05-04T03:44:22.852Z",
    "updated_at": "2016-05-04T03:44:22.855Z"
  },
  "pro_player": [
    {
      "id": 1,
      "player_id": 1,
      "pro_team_id": 1,
      "season": 2012,
      "created_at": "2016-05-04T03:44:22.887Z",
      "updated_at": "2016-05-04T03:44:22.887Z"
    },
    {
      "id": 2,
      "player_id": 1,
      "pro_team_id": 1,
      "season": 2013,
      "created_at": "2016-05-04T03:44:23.995Z",
      "updated_at": "2016-05-04T03:44:23.995Z"
    },
    {
      "id": 3,
      "player_id": 1,
      "pro_team_id": 1,
      "season": 2014,
      "created_at": "2016-05-04T03:44:25.099Z",
      "updated_at": "2016-05-04T03:44:25.099Z"
    },
    {
      "id": 4,
      "player_id": 1,
      "pro_team_id": 1,
      "season": 2015,
      "created_at": "2016-05-04T03:44:25.748Z",
      "updated_at": "2016-05-04T03:44:25.748Z"
    }
  ],
  "pro_team": {
    "id": 1,
    "name": "Florida Panthers",
    "abbreviation": "Fla",
    "yahoo_team_id": 26,
    "logo_url": null,
    "created_at": "2016-05-04T03:44:22.868Z",
    "updated_at": "2016-05-04T03:44:22.868Z"
  },
  "stats": [
    {
      "id": 1,
      "pro_player_id": 1,
      "games_played": 45,
      "goals": 16,
      "assists": 19,
      "points": 35,
      "plus_minus": -2,
      "penalty_minutes": 22,
      "powerplay_goals": 6,
      "powerplay_assists": 5,
      "powerplay_points": 11,
      "shorthanded_goals": 0,
      "shorthanded_assists": 0,
      "shorthanded_points": 0,
      "game_winning_goals": 4,
      "shots_on_goal": 115,
      "shot_percentage": 0.139,
      "faceoffs_won": 0,
      "faceoffs_lost": 1,
      "games_started": null,
      "wins": null,
      "losses": null,
      "goals_against": null,
      "goals_against_average": null,
      "shots_against": null,
      "saves": null,
      "save_percentage": null,
      "shutouts": null,
      "minutes_played": null,
      "hits": 13,
      "blocks": 10,
      "created_at": "2016-05-04T03:44:22.918Z",
      "updated_at": "2016-05-04T03:44:22.928Z"
    },
    {
      "id": 2,
      "pro_player_id": 2,
      "games_played": 82,
      "goals": 24,
      "assists": 43,
      "points": 67,
      "plus_minus": 16,
      "penalty_minutes": 46,
      "powerplay_goals": 5,
      "powerplay_assists": 12,
      "powerplay_points": 17,
      "shorthanded_goals": 0,
      "shorthanded_assists": 0,
      "shorthanded_points": 0,
      "game_winning_goals": 6,
      "shots_on_goal": 231,
      "shot_percentage": 0.104,
      "faceoffs_won": 0,
      "faceoffs_lost": 2,
      "games_started": null,
      "wins": null,
      "losses": null,
      "goals_against": null,
      "goals_against_average": null,
      "shots_against": null,
      "saves": null,
      "save_percentage": null,
      "shutouts": null,
      "minutes_played": null,
      "hits": 4,
      "blocks": 9,
      "created_at": "2016-05-04T03:44:23.999Z",
      "updated_at": "2016-05-04T03:44:24.008Z"
    },
    {
      "id": 3,
      "pro_player_id": 3,
      "games_played": 77,
      "goals": 17,
      "assists": 30,
      "points": 47,
      "plus_minus": -3,
      "penalty_minutes": 48,
      "powerplay_goals": 4,
      "powerplay_assists": 7,
      "powerplay_points": 11,
      "shorthanded_goals": 0,
      "shorthanded_assists": 0,
      "shorthanded_points": 0,
      "game_winning_goals": 5,
      "shots_on_goal": 169,
      "shot_percentage": 0.101,
      "faceoffs_won": 1,
      "faceoffs_lost": 0,
      "games_started": null,
      "wins": null,
      "losses": null,
      "goals_against": null,
      "goals_against_average": null,
      "shots_against": null,
      "saves": null,
      "save_percentage": null,
      "shutouts": null,
      "minutes_played": null,
      "hits": 30,
      "blocks": 14,
      "created_at": "2016-05-04T03:44:25.101Z",
      "updated_at": "2016-05-04T03:44:25.105Z"
    },
    {
      "id": 4,
      "pro_player_id": 4,
      "games_played": 79,
      "goals": 27,
      "assists": 39,
      "points": 66,
      "plus_minus": 23,
      "penalty_minutes": 48,
      "powerplay_goals": 5,
      "powerplay_assists": 6,
      "powerplay_points": 11,
      "shorthanded_goals": 0,
      "shorthanded_assists": 0,
      "shorthanded_points": 0,
      "game_winning_goals": 4,
      "shots_on_goal": 143,
      "shot_percentage": 0.189,
      "faceoffs_won": 0,
      "faceoffs_lost": 1,
      "games_started": null,
      "wins": null,
      "losses": null,
      "goals_against": null,
      "goals_against_average": null,
      "shots_against": null,
      "saves": null,
      "save_percentage": null,
      "shutouts": null,
      "minutes_played": null,
      "hits": 31,
      "blocks": 16,
      "created_at": "2016-05-04T03:44:25.751Z",
      "updated_at": "2016-05-04T03:44:25.756Z"
    }
  ]
}
```

#### get players/one/:yahoo_player_id/:season

*this route is to get one player by yahoo player id, including stats and pro team information for one season*

Params: 
yahoo_player_id: integer
season: integer (use actual years in YYYY format)

**Request**

```
	../players/one/35/2015
```

**Response**
```
{
  "player": {
    "id": 1,
    "first_name": "Jaromir",
    "last_name": "Jagr",
    "yahoo_player_id": 35,
    "headshot_url": "https://s.yimg.com/iu/api/res/1.2/txheDv37R7ZklMNvS.I6fw--/YXBwaWQ9c2hhcmVkO2NoPTIzMzY7Y3I9MTtjdz0xNzkwO2R4PTg1NztkeT0wO2ZpPXVsY3JvcDtoPTYwO3E9MTAwO3c9NDY-/https://s.yimg.com/xe/i/us/sp/v/nhl_cutout/players_l/20151021/35.png",
    "uniform_number": 68,
    "positions": [
      "RW"
    ],
    "created_at": "2016-05-04T03:44:22.852Z",
    "updated_at": "2016-05-04T03:44:22.855Z"
  },
  "pro_player": {
    "id": 4,
    "player_id": 1,
    "pro_team_id": 1,
    "season": 2015,
    "created_at": "2016-05-04T03:44:25.748Z",
    "updated_at": "2016-05-04T03:44:25.748Z"
  },
  "pro_team": {
    "id": 1,
    "name": "Florida Panthers",
    "abbreviation": "Fla",
    "yahoo_team_id": 26,
    "logo_url": null,
    "created_at": "2016-05-04T03:44:22.868Z",
    "updated_at": "2016-05-04T03:44:22.868Z"
  },
  "player_stat": {
    "id": 4,
    "pro_player_id": 4,
    "games_played": 79,
    "goals": 27,
    "assists": 39,
    "points": 66,
    "plus_minus": 23,
    "penalty_minutes": 48,
    "powerplay_goals": 5,
    "powerplay_assists": 6,
    "powerplay_points": 11,
    "shorthanded_goals": 0,
    "shorthanded_assists": 0,
    "shorthanded_points": 0,
    "game_winning_goals": 4,
    "shots_on_goal": 143,
    "shot_percentage": 0.189,
    "faceoffs_won": 0,
    "faceoffs_lost": 1,
    "games_started": null,
    "wins": null,
    "losses": null,
    "goals_against": null,
    "goals_against_average": null,
    "shots_against": null,
    "saves": null,
    "save_percentage": null,
    "shutouts": null,
    "minutes_played": null,
    "hits": 31,
    "blocks": 16,
    "created_at": "2016-05-04T03:44:25.751Z",
    "updated_at": "2016-05-04T03:44:25.756Z"
  }
}
```

#### get players/search

*this route is to search for a player by first name or last name*

Params:
first_name: string
or
last_name: string

i.e.

```
	/players/search?first_name=martin
```
	Will find you all the players with the first name Martin

```
	/players/search?last_name=bergeron
```
	Will find you all the players with the last name Bergeron

#### YAHOO OAUTH ROUTES FOR PULLING FROM API
#### GET oauth/:user_id

*this route is to get a new oauth token*
*not used by the app itself, used to get data from yahoo api*

***Redirects to: oauth/:user_id/authorize***

Params:
user_id: integer

**Request** 

user_id: 3

**Response** 

```
"user": {
"y_access_token": "Bearer PsCdP0ad5llfPSUt2mxZVrlSFshE2w38Ly8XuerAuWqnO1.o3D7T4xb7qwRFERx0woSAJ6AVOCI8rRqUmiEDHcVUQxMu7ez9XbvQLEBAJv.JTp4qOSIIYShMR0Hvh4llY8B0W34FYDgBX.QQX60g3i7fqwl__pF.qgIRa5t3c_waRtYootC8a2GFhsvIwUH0lKfd6hXMqcynSzNM86JhyNEmGBkvJvhyUuB5ilp0su8.hHCMF4sIJ26UKWkCV289vp_K7e.X8s7IAoDlltjxjNZRhHMDutGUh6RWivX5j0hNXJL4mBHs7eqxOumwDWnXQhDKcobh0mUdlCZwaae4BWV.lmDjo7qR21uoRS5SyKMlnflgpsg01ZIkkKoGepELC_4BxKali9zftJICkIfPm1yuN7UgRG5KOgh.CO9CaBKzjCLGK06E07jSGOQNZ09Dt8z6bYVpHg1d7O_qX2kCdzqoRih99hRRrseMIoSS2DAel_asbTIdz.6RIywkiXnvgxNTFhdS2UOCJ5R5uTdBSB1ytiCfr9.OLQGRtaQgcuWMp0i3Ci.V1uqia8f92AAYi70DB6bYMlf2_e8SvyDGY2ZZYqRs0_q7KA22IoODfBYGa24ipkwWpBhjLxmufVpUMx_jJu6JEUpqzJCFaz5nD8fWEakWlW340myyk1hiDsgQ55jrgJpkVp9kcHzWVF4DCsDLXutjzKuwatj2.y_CMBLRtDFyJrl1inoZ8Q5qFPCRPP2R9wXvAtvj2LQddeepwH4yY9VQYZp3Pkyelo9XoBbmR6vS0oBjkAn61s312xdoWMZU7BSnSHI-",
"y_token_type": "bearer",
"y_expires_at": "2016-05-09T18:23:14.403Z",
"y_refresh_token": "ADKBH1cOzxSEkGh8hPN8n3iNDipfNG7zgKZNURLpNnHFJwUjRvFd"
}
}
```