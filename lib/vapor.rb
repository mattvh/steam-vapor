require "vapor/version"


module Vapor


	class Server < Thor


		def initialize(*args)
			super
			@config = STConfig.new
		end


		desc "info <handle> [--ip <ip:port>]", "Display server info"
		option :ip
		def info(handle=nil)
			if (options[:ip])
				parts = options[:ip].strip.split(':')
				ip = parts[0]
				port = parts[1]
			else
				s = @config.lookup_server_by_handle(handle)
				ip = s['ip']
				port = s['port']
			end
			Steam.server_info(ip, port)
		end


		desc "list", "List servers"
		def list()
			Steam.server_listing(@config.data['servers'])
		end


		desc "add <handle> <ip> [port]", "Save a server to the list"
		def add(handle, ip, port=27015)
			@config.add_server(handle, ip, port)
		end


		desc "rm <handle>", "Delete a server from the list"
		def rm(handle)
			@config.rm_server(handle)
		end


		desc "connect <handle>", "Connect to a server"
		def connect(handle)
			s = @config.lookup_server_by_handle(handle)
			uri = "steam://connect/#{s['ip']}:#{s['port']}"
			if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
				system "start #{uri}"
			elsif RbConfig::CONFIG['host_os'] =~ /darwin/
				system "open #{uri}"
			elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
				system "xdg-open #{uri}"
			end
		end


	end



	class User < Thor


		def initialize(*args)
			super
			@config = STConfig.new
		end


		desc "profile <username>", "Display information about a Steam user"
		def profile(username)
			Steam.user_profile(username)
		end


		desc "friends", "Display friends list"
		def friends
			Steam.friends_list(@config.data['me'])
		end


		desc "mynameis <me>", "Tell Vapor your Steam username or numeric Steam ID"
		def mynameis(me)
			@config.set_user(me)
		end


	end



	class CLI < Thor


		def initialize(*args)
			super
			@config = STConfig.new
		end


		desc "server [SUBCOMMAND]", "Query servers"
		subcommand "server", Server


		desc "user [SUBCOMMAND]", "Lookup Steam user details"
		subcommand "user", User


	end



	CLI.start


end