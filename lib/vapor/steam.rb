class Steam



	def self.server_info(ip, port)

		server = self.ping_server(ip, port)

		if server

			server_info = server.server_info

			puts "----------------------------------------------------"
			puts "\033[36m" + server_info[:server_name] + "\033[0m"
			puts "\033[32mPlayers:\033[0m #{server_info[:number_of_players]}/#{server_info[:max_players]} \t \033[32mMap:\033[0m #{server_info[:map_name]}"
			puts "----------------------------------------------------"

			players = server.players.sort_by{ |k, v| v.score }.reverse!

			players.each do |name, info|
				puts "\033[31m#{info.score}\033[0m\t#{name}"
			end

		else

			puts "\nServer #{ip}:#{port} is not responding.\n\n"

		end

	end



	def self.server_listing(servers)

		puts "----------------------------------------------------"

		servers.each do |s|

			server = self.ping_server(s['ip'], s['port'])

			if server
				server_info = server.server_info
				puts "\033[36m[#{s['handle']}]\033[0m  " + server_info[:server_name].squeeze(' ').strip
				puts "\033[32mPlayers:\033[0m #{server_info[:number_of_players]}/#{server_info[:max_players]} \t \033[32mMap:\033[0m #{server_info[:map_name]}"
			else
				puts "\033[36m[#{s['handle']}]\033[0m  server not responding"
			end

			puts "----------------------------------------------------"

		end

	end



	def self.ping_server(ip, port)
		begin
			server = SourceServer.new(ip, port)
		rescue
			server = nil
		end
		return server
	end



	def self.user_profile(user)
		uid = Integer(user) rescue user
		id = SteamId.new(uid)
		puts "\033[36m#{id.nickname}\033[0m"
		puts "\033[32mStatus:\033[0m  #{id.state_message.sub('<br/>',': ')}"
		puts id.summary
	end



	def self.friends_list(me)
		unless me.length > 0
			puts "You have not set your Steam ID yet. Run \"vapor user mynameis <username or numeric ID>\""
			return
		end
		id = SteamId.new(me)
		puts "\n"
		id.friends.each do |f|
			friend = SteamId.new(f.steam_id64)
			uid = (friend.custom_url) ? friend.custom_url : f.steam_id64
			puts "\033[36m#{friend.nickname}\033[0m [#{uid}]"
			puts "#{friend.state_message.sub('<br/>',': ')}\n\n"
		end
	end



end