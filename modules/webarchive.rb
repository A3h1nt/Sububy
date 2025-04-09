module WebArch

	def WebArch.get(domain)
		url = "http://web.archive.org/cdx/search/cdx?url=*.#{domain}&output=text&fl=original&collapse=urlkey"
		webarch_temp = []		
		data = []
		cl = HTTP.headers(
								                "User-Agent"=>"Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0"
		)
		resp = cl.get url
		Fileop.writeS("archive-temp.txt",resp.body)
		data = Fileop.readS("archive-temp.txt")

		data.each do |d|
			begin
				webarch_temp << URI.parse(d.chomp).host
			rescue => e
		#		puts "Some error occured : #{e}" #uncomment to see verbose error
			end
		end
		webarch_temp = webarch_temp.uniq
		$temp_list = ($temp_list+webarch_temp).uniq
		Fileop.write('webarchive.txt',webarch_temp)
		return webarch_temp.count
	end

end
