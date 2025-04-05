module Vtotal
	def Vtotal.getsub(domain)
		vt_host = []
		resp = HTTP.headers("x-apikey"=>"#{$virustotal_api_key}").get "https://www.virustotal.com/api/v3/domains/#{domain}/subdomains?limit=40"
		respj = JSON.parse(resp.body)
		respj['data'].each {|d|vt_host<<d['id']}
		Fileop.write('vtotal.txt',vt_host)
		$temp_list = ($temp_list+vt_host).uniq
		Fileop.append('temp.txt',$temp_list)
		return vt_host
	end
end
