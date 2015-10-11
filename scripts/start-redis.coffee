#!/usr/bin/env coffee



config =		require 'config'
path =			require 'path'
child =			require 'child_process'
fs =			require 'fs'



if not config.has 'redis.pidfile'
	throw new Error 'Missing `redis.pidfile` config.'
pidfile = path.join __dirname, '..', config.get 'redis.pidfile'

if not config.has 'redis.port'
	throw new Error 'Missing `redis.port` config.'
port = config.get 'redis.port'

if not config.has 'redis.databases'
	throw new Error 'Missing `redis.databases` config.'
databases = config.get 'redis.databases'

if not config.has 'redis.dir'
	throw new Error 'Missing `redis.dir` config.'
dir = path.join __dirname, '..', config.get 'redis.dir'



try
	fs.accessSync pidfile
	console.error 'Redis server is already running.'
	process.exit 1

server = child.spawn 'redis-server', [ '-' ],
	stdio:		[ 'pipe', process.stdout, process.stderr ]
	detached:	true
server.stdin.write "port #{port}\n"
server.stdin.write "databases #{databases}\n"
server.stdin.write "dir #{dir}\n"
server.stdin.end()

fs.writeFileSync pidfile, server.pid

console.log "Redis server (#{server.pid}) listening on #{port}."
process.exit 0
