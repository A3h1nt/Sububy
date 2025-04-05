module Dnsd
	$records = ["a","cname","mx","ns"]
	$dnsd_host = []
	def Dnsd.getsub(domain)
		resp = HTTP.headers("X-API-Key" => "#{$dnsdumpster_api_key}").get "https://api.dnsdumpster.com/domain/#{domain}"
		respj = JSON.parse(resp.body)
		$records.each do |k|
			respj[k].each do |h|
#				puts h['host'].chomp
				$dnsd_host << h['host'].chomp
			end
		end	
		Fileop.write('dnsd.txt',$dnsd_host)
		$temp_list = ($temp_list+$dnsd_host).uniq
		Fileop.append('temp.txt',$temp_list)
		return $temp_list
	end	
end
