class STConfig


	attr_reader :data



	def initialize
		@dir = '.config/steamthing'
		@file = 'conf.yaml'
		@data = self.load
	end



	def load
		
		conf = UserConfig.new(@dir)
		yaml = conf[@file]

		if yaml.empty?
			UserConfig.default(@file, {
				'servers' => [
					{ 'handle' => 'rb1', 'ip' => '70.42.74.139', 'port' => 27015 },
					{ 'handle' => '2forttex', 'ip' => '216.144.255.162', 'port' => 27015 }
				]
			})
			conf.create(@file)
			yaml = conf[@file]
		end

		return yaml

	end



	def add_server(handle, ip, port)
		server = { 'handle' => handle, 'ip' => ip, 'port' => port }
		@data['servers'].push(server)
		@data.save
	end



	def rm_server(handle)
		@data['servers'] = @data['servers'].reject { |s| handle == s['handle'] }
		puts @data['servers']
		@data.save
	end



	def lookup_server_by_handle(handle)
		server = @data['servers'].select { |s| handle == s['handle'] }
		return server[0]
	end



	def set_user(me)
		@data['me'] = me
		@data.save
	end



end