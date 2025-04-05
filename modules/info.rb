require 'colorize'

module Info

	$info = {}
	$hosts = []
	def Info.info(filename)
		cl =  HTTP.headers(
			"User-Agent" => "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0"
		)
		$hosts = Live.get(filename)
		$hosts.each do |host|
			begin
				 $info["#{host}"] = HTTP.follow.get "http://#{host}/"              
			rescue => e
				puts "#{host} : Some error occured"
			end
		end
		return $info
	end	

	# returns http headers
	def Info.headers(host)
		Info.check
		$info["#{host}"].headers.each {|h| puts h.to_s.chomp.colorize(:green)}
	end

	#returns headers of all subdomains
	def Info.headersall
		Info.check
		$hosts.each do |host|
			puts "#{host}".colorize(:red)+" -> ";$info["#{host}"].headers.to_a.each {|h| puts h.to_s.chomp.colorize(:green)}
		end
	end

	# returns http status codes	
	def Info.status(host)
		Info.check
		puts = $info[host].status.colorize(:green)
	end

	# returns http status code of all hosts
	def Info.statusall
		Info.check
		$hosts.each do |host|
			puts "#{host}".colorize(:red)+" -> "+$info["#{host}"].status.to_s.colorize(:green)
		end
	end

	# returns title of the webpage
	def Info.title(host)
		Info.check
		puts "#{host}".colorize(:red)+" -> "+$1.colorize(:green) if $info[host].body.to_s =~ /<title>(.*?)<\/title>/i
	end

	# returns title for all the hosts
	def Info.titleall
		Info.check
		$hosts.each do |host|
			puts "#{host}".colorize(:red)+" -> "+$1.colorize(:green) if $info[host].body.to_s =~ /<title>(.*?)<\/title>/i
		end
	end

	# returns files with comments for all hosts
	def Info.comments
		temp_arr = []
		Info.check
		$hosts.each do |host|
			Fileop.write("comments-#{host}.txt",$info["#{host}"].body.to_s.scan(/<!--(.*?)-->/m).to_s.split(","))
		end
		puts 'Comments written to files'
	end

	# returns files with comments for all hosts
	def Info.links
		Info.check
		$hosts.each do |host|
			Fileop.write("links-#{host}.txt",$info["#{host}"].body.to_s.scan(%r{https?://[^\s<>]+}))
		end
		puts 'Comments written to files'
	end

	# checks if info is empty
	def Info.check
		if $info.empty?
			puts "Run Info.info to start" 
		end
	end

end
