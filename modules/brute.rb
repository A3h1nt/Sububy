module Brute
	def Brute.bruteforce(domain,wordlist)
		brute_host = []
		wordlist = Fileop.readw wordlist
		if(domain.is_a? String)
			wordlist.each do |dn|
				begin
					Addrinfo.ip "#{dn.chomp}.#{domain}"
#					puts "#{dn.chomp}.#{domain}" 
					$temp_list << "#{dn.chomp}.#{domain}"
					brute_host << "#{dn.chomp}.#{domain}"
				rescue => e
				end
			end
		elsif
			domain.each do | host |
				wordlist.each do |dn|
					begin
						Addrinfo.ip "#{dn.chomp}.#{host}"
#						puts "#{dn.chomp}.#{host}" 
						brute_host << "#{dn.chomp}.#{host}"
					rescue => e
					end
				end
			end
		end
		brute_host = brute_host.uniq
		Fileop.write('brute.txt',brute_host)
		$temp_list = (brute_host+$temp_list).uniq
		Fileop.append('temp.txt',$temp_list)
		return brute_host
	end
end
