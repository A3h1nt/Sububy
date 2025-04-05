module Sort
	# Given a list of host, sort the host having the domain name
	def Sort.domain(domain,file)
		sort_temp = []
		$temp_list = Fileop.read "#{file}"
		$temp_list.each do | uns |
			if uns.include? "#{domain}"
				sort_temp << uns
			end
		end
		$temp_list = sort_temp.uniq
		Fileop.write('identified_host.txt',$temp_list)
		return $temp_list
	end

	# Given two files of subdomains, combine uniq ones
	def Sort.uniq(file1,file2)
		d1 = Fileop.read file1
		d2 = Fileop.read file2
		return (d1+d2).uniq		
	end

	# Given a file, sort for hosts that have domain name mentioned
	def Sort.sortf(domain,file)
		sortf_temp = []
		d = Fileop.read file
		d.each { |d| sortf_temp << d if d.include?(domain)}
		Fileop.write "sortf.txt",sortf_temp
		return sortf_temp 
	end

end
