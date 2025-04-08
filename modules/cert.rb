module Cert
	def Cert.get(domain)
		cert_host = []
		cl = HTTP.headers(
		                "User-Agent"=>"Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0"
		        )
		begin        
			resp = cl.get "https://crt.sh/json?q=#{domain}"
			respj = JSON.parse(resp.body)
			respj.each do |subds| 
#				puts subds['common_name']  
				cert_host << subds['common_name']
			end
		rescue => e
			puts "Some error occured : #{e}"
		end
			Fileop.write('cert.txt',cert_host)
			$temp_list = (cert_host+$temp_list).uniq
			Fileop.append('temp.txt',$temp_list)
			return $temp_list
	end
end
