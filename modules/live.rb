module Live
	# Find out the live host from the identified hosts
	def Live.get(host_file)
		temp_live = []
		data = Fileop.read "#{host_file}"
		data.each do |dn|
					begin
						dn = dn.chomp
						cli = HTTP.timeout(3).follow.get "http://#{dn}"
# 						puts "#{dn}" Enable output
						temp_live << "#{dn}"
					rescue => e
#						puts "#{dn} : #{e}" #Enable to get verbose error message
					end
			end
		$live_host = ($live_host.concat(temp_live)).uniq
		Fileop.write('live_host.txt',$live_host)
		return $live_host
	end

end
