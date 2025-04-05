module Csp
	def Csp.cspsub(live_host_file,cn)
		data = Fileop.read(live_host_file)	
		csp_temp = []
		data.each do | host |
			cl = HTTP.headers(
				"User-Agent"=>"Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0"
			).timeout(3).follow
			begin
				cl = cl.get "https://#{host.chomp}"
				cl.headers['Content-Security-Policy'].split.each { |h| csp_temp << h if h.include?"#{cn}"}
				csp_temp.each {|d| $csp_list << d.split('*.')[1] if d.include?"*" }
			rescue => e
				#puts "#{e}"
			end
		end
		$csp_list = $csp_list.uniq
		$temp_list = ($temp_list+$csp_list).uniq
		Fileop.write('/csp.txt',$csp_list)
		Fileop.append('temp.txt',$temp_list)
		return $csp_list
	end
end
